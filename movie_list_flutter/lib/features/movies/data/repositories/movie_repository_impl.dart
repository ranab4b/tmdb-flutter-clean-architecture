import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getPopularMovies(int page) async {
    return await remoteDataSource.getPopularMovies(page);
  }

  @override
  Future<List<Movie>> searchMovies(String query, int page) async {
    return await remoteDataSource.searchMovies(query, page);
  }
}
