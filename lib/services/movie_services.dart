import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_rating/model/movie.dart';
import '../const/endpoints.dart';

class MovieService {
  final String _baseUrl = Endpoints.baseUrl;

  Future<PopularMovieResponse> fetchPopularMovies({int page = 1}) async {
    try {
      final uri = Uri.parse('$_baseUrl${Endpoints.popularMovies}').replace(
        queryParameters: {
          'page': '$page',
        },
      );

      final headers = {
        'Authorization': 'Bearer ${Endpoints.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http
          .get(uri, headers: headers)
          .timeout(Endpoints.durationTimeout);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        return PopularMovieResponse.fromJson(decoded);
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }

  Future<PopularMovieResponse> fetchTopRatedMovies({int page = 1}) async {
    try {
      final uri = Uri.parse('$_baseUrl${Endpoints.topRated}').replace(
        queryParameters: {
          'page': '$page',
        },
      );

      final headers = {
        'Authorization': 'Bearer ${Endpoints.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http
          .get(uri, headers: headers)
          .timeout(Endpoints.durationTimeout);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        return PopularMovieResponse.fromJson(decoded);
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }

  Future<PopularMovieResponse> fetchNowPlayingMovie({int page = 1}) async {
    try {
      final uri = Uri.parse('$_baseUrl${Endpoints.nowPlaying}').replace(
        queryParameters: {
          'page': '$page',
        },
      );

      final headers = {
        'Authorization': 'Bearer ${Endpoints.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http
          .get(uri, headers: headers)
          .timeout(Endpoints.durationTimeout);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        return PopularMovieResponse.fromJson(decoded);
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }

  Future<PopularMovieResponse> fetchUpcomingMovie({int page = 1}) async {
    try {
      final uri = Uri.parse('$_baseUrl${Endpoints.upcoming}').replace(
        queryParameters: {
          'page': '$page',
        },
      );

      final headers = {
        'Authorization': 'Bearer ${Endpoints.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http
          .get(uri, headers: headers)
          .timeout(Endpoints.durationTimeout);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        return PopularMovieResponse.fromJson(decoded);
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }

  Future<List<MovieItem>> searchMovie(String query, int page) async {
    final uri = Uri.parse(
      '${Endpoints.baseUrl}${Endpoints.movieSearch(Uri.encodeComponent(query))}&page=$page',
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${Endpoints.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List results = jsonBody['results'];
      return results.map((e) => MovieItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search movies: ${response.statusCode}');
    }
  }
}
