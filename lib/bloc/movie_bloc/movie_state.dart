import 'package:movie_rating/model/movie.dart';

abstract class MovieState {}

class PopularMovieInitial extends MovieState {}

class PopularMovieLoading extends MovieState {
  final List<MovieItem> movies;
  final int page;

  PopularMovieLoading({required this.movies, required this.page});
}

class PopularMovieSuccess extends MovieState {
  final List<MovieItem> movies;
  final int page;
  final bool hasReachedMax;

  PopularMovieSuccess({
    required this.movies,
    required this.page,
    required this.hasReachedMax,
  });
}

class PopularMovieError extends MovieState {
  final String message;
  PopularMovieError(this.message);
}
