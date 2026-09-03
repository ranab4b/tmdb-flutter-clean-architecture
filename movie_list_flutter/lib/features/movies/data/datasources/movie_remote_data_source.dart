import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_list_flutter/core/constants/api_constants.dart';

import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies(int page);
  Future<List<MovieModel>> searchMovies(String query, int page);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  Map<int, String>? _genreCache;

  MovieRemoteDataSourceImpl({required this.client});

  Future<Map<int, String>> _fetchGenres() async {
    if (_genreCache != null) return _genreCache!;

    // Fixed: Removed backslashes before $
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/genre/movie/list?api_key=${ApiConstants.apiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List genres = data['genres'] ?? [];
      _genreCache = {for (var g in genres) g['id'] as int: g['name'] as String};
      return _genreCache!;
    }
    return {};
  }

  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    final genreMap = await _fetchGenres();

    // Fixed: Removed backslashes before $
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/movie/popular?api_key=${ApiConstants.apiKey}&page=$page'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'] ?? [];
      return results.map((json) => MovieModel.fromJson(json, genreMap)).toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query, int page) async {
    final genreMap = await _fetchGenres();
    final encodedQuery = Uri.encodeComponent(query);

    // Fixed: Removed backslashes before $
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/search/movie?api_key=${ApiConstants.apiKey}&query=$encodedQuery&page=$page'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'] ?? [];
      return results.map((json) => MovieModel.fromJson(json, genreMap)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }
}