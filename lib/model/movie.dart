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

class MovieItem {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final bool adult;
  final bool video;
  final List<int> genreIds;
  final String originalTitle;
  final String originalLanguage;
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
