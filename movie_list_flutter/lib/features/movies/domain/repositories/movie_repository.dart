import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies(int page);
  Future<List<Movie>> searchMovies(String query, int page);
}
