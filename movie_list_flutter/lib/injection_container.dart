import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/movies/data/datasources/movie_remote_data_source.dart';
import 'features/movies/data/repositories/movie_repository_impl.dart';
import 'features/movies/domain/repositories/movie_repository.dart';
import 'features/movies/domain/usecases/get_popular_movies.dart';
import 'features/movies/domain/usecases/search_movies.dart';
import 'features/movies/presentation/bloc/movie_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
    () => MovieBloc(
      getPopularMovies: sl(),
      searchMovies: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetPopularMovies(sl()));
  sl.registerLazySingleton(() => SearchMovies(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
