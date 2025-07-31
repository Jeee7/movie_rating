import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_rating/bloc/movie_bloc/popular_movie_bloc.dart';
import 'package:movie_rating/bloc/movie_bloc/movie_event.dart';
import 'package:movie_rating/bloc/movie_bloc/movie_state.dart';
import 'package:movie_rating/bloc/search_bloc/search_bloc.dart';
import 'package:movie_rating/bloc/search_bloc/search_event.dart';
import 'package:movie_rating/bloc/search_bloc/search_state.dart';
import 'package:movie_rating/const/custom_colors.dart';
import 'package:movie_rating/const/endpoints.dart';
import 'package:movie_rating/model/movie.dart';
import 'package:movie_rating/screens/movie_section/movie_card.dart';
import 'package:movie_rating/services/movie_services.dart';
import 'package:movie_rating/utils/search_input.dart';

class PopularMovieDetailPage extends StatefulWidget {
  const PopularMovieDetailPage({super.key});

  @override
  State<PopularMovieDetailPage> createState() => _PopularMovieDetailPageState();
}

class _PopularMovieDetailPageState extends State<PopularMovieDetailPage> {
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  late final SearchMovieBloc _searchMovieBloc;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<PopularMovieBloc>().add(FetchPopularMovies());
    _searchMovieBloc = context.read<SearchMovieBloc>();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        if (_searchQuery.isEmpty) {
          context.read<PopularMovieBloc>().add(FetchPopularMoviesNextPage());
        } else {
          final state = context.read<SearchMovieBloc>().state;
          if (state is SearchMovieSuccess && !state.hasReachedMax) {
            // context.read<SearchMovieBloc>().add(SearchMovieFetchMore());
          }
        }
      }
    });
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchQuery = query;
      });
      context.read<SearchMovieBloc>().add(SearchMovie(query: query));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );

    return BlocProvider.value(
      value: _searchMovieBloc,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          backgroundColor: colors.background,
          title: const Text("Popular Movies"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchField(
                onChanged: _onSearchChanged,
              ),
            ),
            Expanded(
              child: _searchQuery.isEmpty
                  ? _buildPopularMovieList()
                  : _buildSearchMovieList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularMovieList() {
    return BlocBuilder<PopularMovieBloc, MovieState>(
      builder: (context, state) {
        if (state is PopularMovieLoading && state.movies.isEmpty) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.55,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 12,
            itemBuilder: (context, index) {
              return const MovieCard(isLoading: true);
            },
          );
        } else if (state is PopularMovieError) {
          return Center(
            child: Text(
              "Error: ${state.message}",
            ),
          );
        } else if (state is PopularMovieSuccess) {
          final movies = state.movies;
          return _buildMovieGrid(movies);
        } else if (state is PopularMovieLoading) {
          final movies = state.movies;
          return _buildMovieGrid(
            movies,
            isLoading: true,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildSearchMovieList() {
    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      builder: (context, state) {
        if (state is SearchMovieLoading) {
          return _buildLoadingGrid();
        } else if (state is SearchMovieError) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is SearchMovieSuccess) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return const Center(child: Text("No results found."));
          }
          return _buildMovieGrid(
            movies,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.5,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return const MovieCard(isLoading: true);
      },
    );
  }

  Widget _buildMovieGrid(List<MovieItem> movies, {bool isLoading = false}) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.5,
      ),
      itemCount: movies.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (isLoading && index >= movies.length) {
          return const Center(child: CircularProgressIndicator());
        }

        final movie = movies[index];
        final title = movie.title;
        final imageUrl = '${Endpoints.imageBaseUrl}${movie.posterPath}';

        return MovieCard(
          title: title,
          imageUrl: imageUrl,
        );
      },
    );
  }
}
