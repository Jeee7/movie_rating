import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_rating/bloc/search_bloc/search_event.dart';
import 'package:movie_rating/bloc/search_bloc/search_state.dart';
import 'package:movie_rating/services/movie_services.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final MovieService service;

  SearchMovieBloc(this.service) : super(SearchMovieInitial()) {
    on<SearchMovie>(
      _onFetchSearchMovies,
      transformer: droppable(),
    );

    on<ClearSearchMovie>((event, emit) {
      emit(SearchMovieInitial());
    });
  }

  Future<void> _onFetchSearchMovies(
    SearchMovie event,
    Emitter<SearchMovieState> emit,
  ) async {
    try {
      if (event.query.isEmpty) return;

      final currentState = state;

      // Check if this is a new search query or pagination
      final bool isNewSearch = currentState is! SearchMovieSuccess ||
          currentState.query != event.query;

      if (isNewSearch) {
        // New search - start from page 1 and emit loading
        emit(SearchMovieLoading());

        final movies = await service.searchMovie(event.query, 1);
        final hasReachedMax = movies.isEmpty;

        emit(SearchMovieSuccess(
          movies,
          1,
          hasReachedMax,
          event.query, // Store the query in the state
        ));
      } else {
        // Pagination of existing search
        if (currentState.hasReachedMax) return;

        final nextPage = currentState.page + 1;
        final movies = await service.searchMovie(event.query, nextPage);
        final hasReachedMax = movies.isEmpty;

        final allMovies = [...currentState.movies, ...movies];

        emit(SearchMovieSuccess(
          allMovies,
          nextPage,
          hasReachedMax,
          event.query,
        ));
      }
    } catch (e) {
      emit(SearchMovieError(e.toString()));
    }
  }
}
