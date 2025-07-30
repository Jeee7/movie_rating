class Endpoints {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  static const String popularMovies = '/movie/popular';
  static const String nowPlaying = '/movie/now_playing';
  static const String upcoming = '/movie/upcoming';
  static const String topRated = '/movie/top_rated';

  static String movieDetail(int id) => '/movie/$id';

  static const Duration durationTimeout = Duration(seconds: 10);

  static const accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYjA4MTY1NjdiMzJhMjgxNTA0NjQxMmZhZGFhZTc3YSIsIm5iZiI6MTc1MzgwOTM1MC4yMzgwMDAyLCJzdWIiOiI2ODg5MDFjNmJjOGJlOWJlYWZkNWE2YzMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.4CoZTJSW0kCczzJljjodN0O7h-MxkPdMAY91agHNs9M';
}
