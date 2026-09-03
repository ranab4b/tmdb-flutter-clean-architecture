import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPopularMoviesEvent extends MovieEvent {}

class SearchMoviesEvent extends MovieEvent {
  final String query;
  SearchMoviesEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadMoreMoviesEvent extends MovieEvent {}
