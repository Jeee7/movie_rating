import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_rating/bloc/movie_bloc/movie_event.dart';
import 'package:movie_rating/bloc/movie_bloc/movie_state.dart';
import 'package:movie_rating/bloc/movie_bloc/top_rated_movie_bloc.dart';
import 'package:movie_rating/bloc/search_bloc/search_bloc.dart';
import 'package:movie_rating/const/divider.dart';
import 'package:movie_rating/const/endpoints.dart';
import 'package:movie_rating/screens/movie_section/components/bottom_sheet_info.dart';
import 'package:movie_rating/screens/movie_section/components/movie_card.dart';
import 'package:movie_rating/screens/movie_section/top_rated_movie_detail_.dart';

class TopRatedMovieList extends StatefulWidget {
  const TopRatedMovieList({super.key});

  @override
  State<TopRatedMovieList> createState() => _TopRatedMovieListState();
}

class _TopRatedMovieListState extends State<TopRatedMovieList> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedMovieBloc>().add(FetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Rated Movies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: context.read<TopRatedMovieBloc>(),
                          ),
                          BlocProvider.value(
                            value: context.read<SearchMovieBloc>(),
                          ),
                        ],
                        child: const TopRatedMovieDetail(),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'See More',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        gapHeight(4),
        SizedBox(
          height: 200,
          child: BlocBuilder<TopRatedMovieBloc, MovieState>(
            builder: (context, state) {
              if (state is TopRatedMovieLoading) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const MovieCard(isLoading: true);
                  },
                );
              } else if (state is TopRatedMovieSuccess) {
                final movies = state.movies;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return MovieCard(
                      isLoading: false,
                      title: movie.title,
                      imageUrl: '${Endpoints.imageBaseUrl}${movie.posterPath}',
                      onTap: () {
                        BottomSheetInfo.show(context, movie);
                      },
                    );
                  },
                );
              } else if (state is TopRatedMovieError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
