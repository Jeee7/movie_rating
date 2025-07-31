import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_rating/bloc/movie_bloc/movie_event.dart';
import 'package:movie_rating/bloc/movie_bloc/movie_state.dart';
import 'package:movie_rating/bloc/movie_bloc/upcoming_movie_bloc.dart';
import 'package:movie_rating/const/divider.dart';
import 'package:movie_rating/const/endpoints.dart';
import 'package:movie_rating/screens/movie_section/components/bottom_sheet_info.dart';
import 'package:movie_rating/screens/movie_section/components/movie_card.dart';

class UpcomingMovieList extends StatefulWidget {
  const UpcomingMovieList({super.key});

  @override
  State<UpcomingMovieList> createState() => _UpcomingMovieListState();
}

class _UpcomingMovieListState extends State<UpcomingMovieList> {
  @override
  void initState() {
    super.initState();
    context.read<UpcomingMovieBloc>().add(FetchUpcomingMovies());
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
                'Upcoming Movies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => BlocProvider.value(
                  //       value: context.read<UpcomingMovieBloc>(),
                  //       child: const PopularMovieDetailPage(),
                  //     ),
                  //   ),
                  // );
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
          child: BlocBuilder<UpcomingMovieBloc, MovieState>(
            builder: (context, state) {
              if (state is UpcomingMovieLoading) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const MovieCard(isLoading: true);
                  },
                );
              } else if (state is UpcomingMovieSuccess) {
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
              } else if (state is UpcomingMovieError) {
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
