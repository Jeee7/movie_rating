import 'package:movie_rating/model/movie.dart';

abstract class SearchMovieState {}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieSuccess extends SearchMovieState {
  final List<MovieItem> movies;
  final int page;
  final bool hasReachedMax;
  final String query;

  SearchMovieSuccess(
    this.movies,
    this.page,
    this.hasReachedMax,
    this.query,
  );
  @override
  List<Object?> get props => [movies, page, hasReachedMax, query];
}

class SearchMovieError extends SearchMovieState {
  final String message;
  SearchMovieError(this.message);
}
