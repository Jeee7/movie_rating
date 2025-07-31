import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:movie_rating/const/custom_colors.dart';
import 'package:movie_rating/const/divider.dart';
import 'package:movie_rating/const/endpoints.dart';
import 'package:movie_rating/model/movie.dart';
import 'package:movie_rating/utils/snackbar.dart';

class BottomSheetInfo {
  static void show(BuildContext context, MovieItem movie) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final box = Hive.box('watchlistBox');
    final watchlist = box.get('watchlist', defaultValue: <int>[]).cast<int>();
    final isInWatchlist = watchlist.contains(movie.id);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: colors.background,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setState) {
                return SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            '${Endpoints.imageBaseUrl}${movie.posterPath}',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fitHeight,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      gapHeight(16),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      gapHeight(8),
                      Text(
                        'Release Date: ${movie.releaseDate}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      gapHeight(4),
                      Text(
                        'Rating: ${movie.voteAverage}/10',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      gapHeight(4),
                      Text(
                        'Popularity: ${movie.popularity}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      gapHeight(16),
                      Text(
                        movie.overview ?? 'No overview available.',
                        style: const TextStyle(fontSize: 14),
                      ),
                      gapHeight(24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          // In your BottomSheetInfo.show method, replace the button's onPressed logic:

                          onPressed: () {
                            final box = Hive.box('watchlistBox');
                            final currentIds = box.get('watchlist_ids',
                                defaultValue: <int>[]).cast<int>();
                            final currentMovies = box.get('watchlist_movies',
                                defaultValue: <MovieItem>[]).cast<MovieItem>();

                            if (currentIds.contains(movie.id)) {
                              // Remove from watchlist
                              currentIds.remove(movie.id);
                              currentMovies
                                  .removeWhere((m) => m.id == movie.id);

                              snackBarTrigger(
                                  context, 'Berhasil Menghapus WatchList');
                            } else {
                              // Add to watchlist
                              currentIds.add(movie.id);
                              currentMovies.add(movie);

                              snackBarTrigger(
                                  context, 'Berhasil Menambah WatchList');
                              Navigator.pop(context);
                            }

                            box.put('watchlist_ids', currentIds);
                            box.put('watchlist_movies', currentMovies);
                            setState(() {});
                          },
                          icon: Icon(
                            isInWatchlist
                                ? Icons.bookmark_remove
                                : Icons.bookmark_add,
                          ),
                          label: Text(
                            isInWatchlist
                                ? 'Remove from Watchlist'
                                : 'Add to Watchlist',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
