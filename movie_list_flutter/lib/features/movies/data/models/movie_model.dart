import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
    required super.voteAverage,
    required super.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json, Map<int, String> genreMap) {
    List<int> genreIds = (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [];
    List<String> genreNames = genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();

    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      overview: json['overview'] ?? 'No Overview Available.',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'N/A',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      genres: genreNames,
    );
  }
}
