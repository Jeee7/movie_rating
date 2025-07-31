import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_rating/model/movie.dart';
import 'package:movie_rating/services/movie_services.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class NowShowingMovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _movieService;

  NowShowingMovieBloc(this._movieService) : super(NowShowingMovieInitial()) {
    on<FetchNowShowingMovies>(_onFetchNowShowingMovie);
    on<FetchNowShowingMovieNextPage>(_onFetchNowShowingMovieNextPage);
  }

  Future<void> _onFetchNowShowingMovie(
    FetchNowShowingMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(PopularMovieLoading(movies: [], page: 1));
    try {
      final movies = await _movieService.fetchNowPlayingMovie();
      emit(NowShowingMovieSuccess(
        movies: movies.results,
        page: movies.page,
        hasReachedMax: movies.page >= movies.totalPages,
      ));
    } catch (e) {
      emit(PopularMovieError(e.toString()));
    }
  }

  Future<void> _onFetchNowShowingMovieNextPage(
    FetchNowShowingMovieNextPage event,
    Emitter<MovieState> emit,
  ) async {
    final currentState = state;
    if (currentState is PopularMovieSuccess && !currentState.hasReachedMax) {
      try {
        final nextPage = currentState.page + 1;
        emit(NowShowingMovieLoading(
          movies: currentState.movies,
          page: currentState.page,
        ));

        final response =
            await _movieService.fetchNowPlayingMovie(page: nextPage);

        final newMovies = List<MovieItem>.from(currentState.movies)
          ..addAll(response.results);

        emit(NowShowingMovieSuccess(
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
