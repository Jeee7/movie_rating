import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_rating/bloc/movie_bloc/now_showing_movie_bloc.dart';
import 'package:movie_rating/bloc/movie_bloc/popular_movie_bloc.dart';
import 'package:movie_rating/bloc/movie_bloc/top_rated_movie_bloc.dart';
import 'package:movie_rating/bloc/movie_bloc/upcoming_movie_bloc.dart';
import 'package:movie_rating/bloc/search_bloc/search_bloc.dart';
import 'package:movie_rating/const/custom_colors.dart';
import 'package:movie_rating/const/divider.dart';
import 'package:movie_rating/screens/movie_section/now_showing_movie.dart';
import 'package:movie_rating/screens/movie_section/popular_movie_list.dart';
import 'package:movie_rating/screens/movie_section/top_rated_movie.dart';
import 'package:movie_rating/screens/movie_section/upcoming_movie_list.dart';
import 'package:movie_rating/screens/movie_section/watchlist.dart';
import 'package:movie_rating/services/movie_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Movie App'),
        backgroundColor: colors.background,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<PopularMovieBloc>(
            create: (context) => PopularMovieBloc(MovieService()),
          ),
          BlocProvider<TopRatedMovieBloc>(
            create: (context) => TopRatedMovieBloc(MovieService()),
          ),
          BlocProvider<NowShowingMovieBloc>(
            create: (context) => NowShowingMovieBloc(MovieService()),
          ),
          BlocProvider<UpcomingMovieBloc>(
            create: (context) => UpcomingMovieBloc(MovieService()),
          ),
          BlocProvider<SearchMovieBloc>(
            create: (context) => SearchMovieBloc(MovieService()),
          ),
        ],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PopularMovieList(),
              gapHeight(16),
              const TopRatedMovieList(),
              gapHeight(16),
              const NowShowingMovie(),
              gapHeight(16),
              const UpcomingMovieList(),
              gapHeight(16),
              const WatchlistSection(),
            ],
          ),
        ),
      ),
    );
  }
}
