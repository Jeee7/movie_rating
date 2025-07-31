import 'package:hive/hive.dart';
part 'movie.g.dart';

class PopularMovieResponse {
  final int page;
  final List<MovieItem> results;
  final int totalPages;
  final int totalResults;

  PopularMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularMovieResponse.fromJson(Map<String, dynamic> json) {
    return PopularMovieResponse(
      page: json['page'],
      results:
          (json['results'] as List).map((e) => MovieItem.fromJson(e)).toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}

@HiveType(typeId: 0) // typeId HARUS unik dalam project Hive-mu
class MovieItem extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String overview;

  @HiveField(3)
  final String? posterPath;

  @HiveField(4)
  final String? backdropPath;

  @HiveField(5)
  final String releaseDate;

  @HiveField(6)
  final double voteAverage;

  @HiveField(7)
  final int voteCount;

  @HiveField(8)
  final bool adult;

  @HiveField(9)
  final bool video;

  @HiveField(10)
  final List<int> genreIds;

  @HiveField(11)
  final String originalTitle;

  @HiveField(12)
  final String originalLanguage;

  @HiveField(13)
  final double popularity;

  MovieItem({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.adult,
    required this.video,
    required this.genreIds,
    required this.originalTitle,
    required this.originalLanguage,
    required this.popularity,
  });

  factory MovieItem.fromJson(Map<String, dynamic> json) => MovieItem(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
        releaseDate: json['release_date'],
        voteAverage: (json['vote_average'] as num).toDouble(),
        voteCount: json['vote_count'],
        adult: json['adult'],
        video: json['video'],
        genreIds: List<int>.from(json['genre_ids']),
        originalTitle: json['original_title'],
        originalLanguage: json['original_language'],
        popularity: (json['popularity'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'overview': overview,
        'poster_path': posterPath,
        'backdrop_path': backdropPath,
        'release_date': releaseDate,
        'vote_average': voteAverage,
        'vote_count': voteCount,
        'adult': adult,
        'video': video,
        'genre_ids': genreIds,
        'original_title': originalTitle,
        'original_language': originalLanguage,
        'popularity': popularity,
      };
}
