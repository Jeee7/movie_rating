import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_rating/model/movie.dart';
import 'package:movie_rating/services/movie_services.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _movieService;

  MovieBloc(this._movieService) : super(PopularMovieInitial()) {
    on<FetchPopularMovies>(_onFetchPopularMovies);
    on<FetchPopularMoviesNextPage>(_onFetchPopularMoviesNextPage);
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(PopularMovieLoading(movies: [], page: 1));
    try {
      final movies = await _movieService.fetchPopularMovies();
      emit(PopularMovieSuccess(
        movies: movies.results,
        page: movies.page,
        hasReachedMax: movies.page >= movies.totalPages,
      ));
    } catch (e) {
      emit(PopularMovieError(e.toString()));
    }
  }

  Future<void> _onFetchPopularMoviesNextPage(
    FetchPopularMoviesNextPage event,
    Emitter<MovieState> emit,
  ) async {
    final currentState = state;
    if (currentState is PopularMovieSuccess && !currentState.hasReachedMax) {
      try {
        final nextPage = currentState.page + 1;
        emit(PopularMovieLoading(
          movies: currentState.movies,
          page: currentState.page,
        ));

        final response = await _movieService.fetchPopularMovies(page: nextPage);

        final newMovies = List<MovieItem>.from(currentState.movies)
          ..addAll(response.results);

        emit(PopularMovieSuccess(
          movies: newMovies,
          page: response.page,
          hasReachedMax: response.page >= response.totalPages,
        ));
      } catch (e) {
        emit(PopularMovieError(e.toString()));
      }
    }
  }
}
