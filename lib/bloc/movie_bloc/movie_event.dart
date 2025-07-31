abstract class MovieEvent {}

class FetchPopularMovies extends MovieEvent {}

class FetchPopularMoviesNextPage extends MovieEvent {}

class FetchTopRatedMovies extends MovieEvent {}

class FetchTopRatedMoviesNextPage extends MovieEvent {}

class FetchNowShowingMovies extends MovieEvent {}

class FetchNowShowingMovieNextPage extends MovieEvent {}

class FetchUpcomingMovies extends MovieEvent {}

class FetchUpcomingMoviesNextPage extends MovieEvent {}
