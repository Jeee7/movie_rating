import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_rating/model/movie.dart';
import 'package:movie_rating/services/movie_services.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class UpcomingMovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _movieService;

  UpcomingMovieBloc(this._movieService) : super(UpcomingMovieInitial()) {
    on<FetchUpcomingMovies>(_onFetchUpcomingMovie);
    on<FetchUpcomingMoviesNextPage>(_onFetchUpcomingMovieNextPage);
  }

  Future<void> _onFetchUpcomingMovie(
    FetchUpcomingMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(UpcomingMovieLoading(movies: [], page: 1));
    try {
      final movies = await _movieService.fetchUpcomingMovie();
      emit(UpcomingMovieSuccess(
        movies: movies.results,
        page: movies.page,
        hasReachedMax: movies.page >= movies.totalPages,
      ));
    } catch (e) {
      emit(UpcomingMovieError(e.toString()));
    }
  }

  Future<void> _onFetchUpcomingMovieNextPage(
    FetchUpcomingMoviesNextPage event,
    Emitter<MovieState> emit,
  ) async {
    final currentState = state;
    if (currentState is UpcomingMovieSuccess && !currentState.hasReachedMax) {
      try {
        final nextPage = currentState.page + 1;
        emit(UpcomingMovieLoading(
          movies: currentState.movies,
          page: currentState.page,
        ));

        final response = await _movieService.fetchUpcomingMovie(page: nextPage);

        final newMovies = List<MovieItem>.from(currentState.movies)
          ..addAll(response.results);

        emit(UpcomingMovieSuccess(
          movies: newMovies,
          page: response.page,
          hasReachedMax: response.page >= response.totalPages,
        ));
      } catch (e) {
        emit(UpcomingMovieError(e.toString()));
      }
    }
  }
}
