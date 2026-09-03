import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_list_flutter/features/movies/domain/entities/movie.dart';
import 'package:movie_list_flutter/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:movie_list_flutter/features/movies/domain/usecases/search_movies.dart';
import 'package:movie_list_flutter/features/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_list_flutter/features/movies/presentation/bloc/movie_event.dart';
import 'package:movie_list_flutter/features/movies/presentation/bloc/movie_state.dart';


class MockGetPopularMovies extends Mock implements GetPopularMovies {}
class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  late MovieBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    mockSearchMovies = MockSearchMovies();
    bloc = MovieBloc(
      getPopularMovies: mockGetPopularMovies,
      searchMovies: mockSearchMovies,
    );
  });

  const tMovie = Movie(
    id: 1,
    title: 'Inception',
    overview: 'A thief who steals corporate secrets...',
    posterPath: '/path.jpg',
    releaseDate: '2010-07-16',
    voteAverage: 8.8,
    genres: ['Action', 'Sci-Fi'],
  );

  test('initial state should be MovieInitialState', () {
    expect(bloc.state, equals(MovieInitialState()));
  });

  test('should emit [MovieLoadingInitialState, MovieLoadedState] when popular movies fetched successfully', () async {
    when(() => mockGetPopularMovies(1)).thenAnswer((_) async => [tMovie]);

    final expected = [
      MovieLoadingInitialState("Preparing the experience for you, hold on with us..."),
      MovieLoadedState(movies: const [tMovie], hasReachedMax: false),
    ];

    expectLater(bloc.stream, emitsInOrder(expected));
    bloc.add(FetchPopularMoviesEvent());
  });
}
