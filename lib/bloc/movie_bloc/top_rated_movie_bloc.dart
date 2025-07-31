import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_rating/services/movie_services.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _movieService;

  TopRatedMovieBloc(this._movieService) : super(PopularMovieInitial()) {
    on<FetchTopRatedMovies>(_onFetchTopRatedMovies);
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
}
