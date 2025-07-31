import 'package:movie_rating/model/movie.dart';

abstract class MovieState {}

class PopularMovieInitial extends MovieState {}

class TopRatedMovieInitial extends MovieState {}

class NowShowingMovieInitial extends MovieState {}

class UpcomingMovieInitial extends MovieState {}

class PopularMovieLoading extends MovieState {
  final List<MovieItem> movies;
  final int page;

  PopularMovieLoading({required this.movies, required this.page});
}

class TopRatedMovieLoading extends MovieState {
  final List<MovieItem> movies;
  final int page;

  TopRatedMovieLoading({required this.movies, required this.page});
}

class NowShowingMovieLoading extends MovieState {
  final List<MovieItem> movies;
  final int page;

  NowShowingMovieLoading({required this.movies, required this.page});
}

class UpcomingMovieLoading extends MovieState {
  final List<MovieItem> movies;
  final int page;

  UpcomingMovieLoading({required this.movies, required this.page});
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

class TopRatedMovieSuccess extends MovieState {
  final List<MovieItem> movies;
  final int page;
  final bool hasReachedMax;

  TopRatedMovieSuccess({
    required this.movies,
    required this.page,
    required this.hasReachedMax,
  });
}

class NowShowingMovieSuccess extends MovieState {
  final List<MovieItem> movies;
  final int page;
  final bool hasReachedMax;

  NowShowingMovieSuccess({
    required this.movies,
    required this.page,
    required this.hasReachedMax,
  });
}

class UpcomingMovieSuccess extends MovieState {
  final List<MovieItem> movies;
  final int page;
  final bool hasReachedMax;

  UpcomingMovieSuccess({
    required this.movies,
    required this.page,
    required this.hasReachedMax,
  });
}

class PopularMovieError extends MovieState {
  final String message;
  PopularMovieError(this.message);
}

class TopRatedMovieError extends MovieState {
  final String message;
  TopRatedMovieError(this.message);
}

class NowShowingMovieError extends MovieState {
  final String message;
  NowShowingMovieError(this.message);
}

class UpcomingMovieError extends MovieState {
  final String message;
  UpcomingMovieError(this.message);
}
