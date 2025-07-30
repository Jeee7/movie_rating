import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_rating/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_rating/bloc/movie_bloc/movie_event.dart';
import 'package:movie_rating/bloc/movie_bloc/movie_state.dart';
import 'package:movie_rating/const/custom_colors.dart';
import 'package:movie_rating/const/endpoints.dart';
import 'package:movie_rating/model/movie.dart';
import 'package:movie_rating/screens/home/components/movie_card.dart';

class PopularMovieDetailPage extends StatefulWidget {
  const PopularMovieDetailPage({super.key});

  @override
  State<PopularMovieDetailPage> createState() => _PopularMovieDetailPageState();
}

class _PopularMovieDetailPageState extends State<PopularMovieDetailPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(FetchPopularMovies());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<MovieBloc>().add(FetchPopularMoviesNextPage());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        title: const Text(
          "Popular Movies",
        ),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
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
      ),
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
        final string = movie.posterPath;
        return MovieCard(
          title: title,
          imageUrl: '${Endpoints.imageBaseUrl}$string',
        );
      },
    );
  }
}
