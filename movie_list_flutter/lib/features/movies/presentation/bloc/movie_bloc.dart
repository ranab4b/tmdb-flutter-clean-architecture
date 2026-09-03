import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/search_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies getPopularMovies;
  final SearchMovies searchMovies;

  int _currentPage = 1;
  String _currentQuery = '';

  MovieBloc({
    required this.getPopularMovies,
    required this.searchMovies,
  }) : super(MovieInitialState()) {
    on<FetchPopularMoviesEvent>(_onFetchPopularMovies);
    on<SearchMoviesEvent>(_onSearchMovies);
    on<LoadMoreMoviesEvent>(_onLoadMoreMovies);
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    _currentPage = 1;
    _currentQuery = '';
    emit(MovieLoadingInitialState("Preparing the experience for you, hold on with us..."));
    try {
      final movies = await getPopularMovies(_currentPage);
      emit(MovieLoadedState(movies: movies, hasReachedMax: movies.isEmpty));
    } catch (e) {
      emit(MovieErrorState("Failed to fetch movies. Please check connection and API key."));
    }
  }

  Future<void> _onSearchMovies(
    SearchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    _currentQuery = event.query.trim();
    _currentPage = 1;

    if (_currentQuery.isEmpty) {
      add(FetchPopularMoviesEvent());
      return;
    }

    emit(MovieLoadingInitialState("Searching movies..."));
    try {
      final movies = await searchMovies(_currentQuery, _currentPage);
      emit(MovieLoadedState(movies: movies, hasReachedMax: movies.isEmpty));
    } catch (e) {
      emit(MovieErrorState("Error while searching. Please try again."));
    }
  }

  Future<void> _onLoadMoreMovies(
    LoadMoreMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    final currentState = state;
    if (currentState is MovieLoadedState &&
        !currentState.hasReachedMax &&
        !currentState.isLoadingMore) {
      emit(currentState.copyWith(isLoadingMore: true));
      try {
        _currentPage++;
        final newMovies = _currentQuery.isEmpty
            ? await getPopularMovies(_currentPage)
            : await searchMovies(_currentQuery, _currentPage);

        if (newMovies.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true, isLoadingMore: false));
        } else {
          emit(MovieLoadedState(
            movies: currentState.movies + newMovies,
            hasReachedMax: false,
            isLoadingMore: false,
          ));
        }
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    }
  }
}
