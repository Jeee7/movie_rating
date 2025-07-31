import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_rating/model/movie.dart';
import 'package:movie_rating/screens/movie_section/components/bottom_sheet_info.dart';
import 'package:movie_rating/screens/movie_section/components/movie_card.dart';

class WatchlistSection extends StatelessWidget {
  const WatchlistSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('watchlistBox').listenable(),
      builder: (context, Box box, _) {
        final stored = box.get('watchlist_movies', defaultValue: <MovieItem>[]);
        final watchlist = stored.cast<MovieItem>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'My Watchlist',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: watchlist.length,
                itemBuilder: (context, index) {
                  final movie = watchlist[index];
                  return MovieCard(
                    title: movie.title,
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    onTap: () {
                      BottomSheetInfo.show(context, movie);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
