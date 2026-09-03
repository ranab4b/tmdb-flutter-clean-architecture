import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final List<String> genres;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genres,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        releaseDate,
        voteAverage,
        genres,
      ];
}
