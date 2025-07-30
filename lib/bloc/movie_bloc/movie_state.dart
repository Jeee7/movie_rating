import 'package:movie_rating/model/movie.dart';

abstract class MovieState {}

class PopularMovieInitial extends MovieState {}

class PopularMovieLoading extends MovieState {}

class PopularMovieSuccess extends MovieState {
  final PopularMovieResponse movies;
  PopularMovieSuccess(this.movies);
}

class PopularMovieError extends MovieState {
  final String message;
  PopularMovieError(this.message);
}
