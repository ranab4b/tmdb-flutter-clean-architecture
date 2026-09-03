import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInitialState extends MovieState {}

class MovieLoadingInitialState extends MovieState {
  final String message;
  MovieLoadingInitialState(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieLoadedState extends MovieState {
  final List<Movie> movies;
  final bool hasReachedMax;
  final bool isLoadingMore;

  MovieLoadedState({
    required this.movies,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  MovieLoadedState copyWith({
    List<Movie>? movies,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return MovieLoadedState(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [movies, hasReachedMax, isLoadingMore];
}

class MovieErrorState extends MovieState {
  final String message;
  MovieErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
