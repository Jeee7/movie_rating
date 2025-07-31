import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_rating/model/movie.dart';
import 'package:movie_rating/screens/movie_section/components/bottom_sheet_info.dart';
import 'package:movie_rating/screens/movie_section/components/movie_card.dart';

class WatchlistSection extends StatefulWidget {
  const WatchlistSection({super.key});

  @override
  State<WatchlistSection> createState() => _WatchlistSectionState();
}

class _WatchlistSectionState extends State<WatchlistSection> {
  List<MovieItem> _watchlist = [];

  @override
  void initState() {
    super.initState();
    _loadWatchlist();
  }

  void _loadWatchlist() {
    final box = Hive.box('watchlistBox');
    final stored = box.get('watchlist', defaultValue: []);
    print('RAW STORED: $stored');
    print('TYPE: ${stored.runtimeType}');

    setState(() {
      _watchlist = stored.whereType<MovieItem>().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_watchlist.isEmpty) return const SizedBox();

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
            itemCount: _watchlist.length,
            itemBuilder: (context, index) {
              final movie = _watchlist[index];
              return MovieCard(
                title: movie.title,
                imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                onTap: () {
                  BottomSheetInfo.show(context, movie);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
