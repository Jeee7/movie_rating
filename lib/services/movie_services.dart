import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_rating/model/movie.dart';
import '../const/endpoints.dart';

class MovieService {
  final String _baseUrl = Endpoints.baseUrl;

  Future<PopularMovieResponse> fetchPopularMovies() async {
    try {
      final uri = Uri.parse('$_baseUrl${Endpoints.popularMovies}');

      final headers = {
        'Authorization': 'Bearer ${Endpoints.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http
          .get(uri, headers: headers)
          .timeout(Endpoints.durationTimeout);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List results = decoded['results'];

        return PopularMovieResponse.fromJson(decoded);
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }
}
