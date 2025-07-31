import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_rating/model/movie.dart';
import 'package:movie_rating/services/movie_services.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _movieService;

  TopRatedMovieBloc(this._movieService) : super(TopRatedMovieInitial()) {
    on<FetchTopRatedMovies>(_onFetchTopRatedMovies);
    on<FetchTopRatedMoviesNextPage>(_onFetchTopRatedMoviesNextPage);
  }

  Future<void> _onFetchTopRatedMovies(
    FetchTopRatedMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(TopRatedMovieLoading(movies: [], page: 1));
    try {
      final movies = await _movieService.fetchTopRatedMovies();
      emit(TopRatedMovieSuccess(
        movies: movies.results,
        page: movies.page,
        hasReachedMax: movies.page >= movies.totalPages,
      ));
    } catch (e) {
      emit(TopRatedMovieError(e.toString()));
    }
  }

  Future<void> _onFetchTopRatedMoviesNextPage(
    FetchTopRatedMoviesNextPage event,
    Emitter<MovieState> emit,
  ) async {
    final currentState = state;
    if (currentState is TopRatedMovieSuccess && !currentState.hasReachedMax) {
      try {
        final nextPage = currentState.page + 1;
        emit(TopRatedMovieLoading(
          movies: currentState.movies,
          page: currentState.page,
        ));

        final response =
            await _movieService.fetchTopRatedMovies(page: nextPage);

        final newMovies = List<MovieItem>.from(currentState.movies)
          ..addAll(response.results);

        emit(TopRatedMovieSuccess(
          movies: newMovies,
          page: response.page,
          hasReachedMax: response.page >= response.totalPages,
        ));
      } catch (e) {
        emit(TopRatedMovieError(e.toString()));
      }
    }
  }
}
