import 'package:simple_movie_app/api/ApiClient.dart';
import 'package:simple_movie_app/models/movie.dart';

class MoviesRepository {
  final ApiClient apiClient = ApiClient();

  Future getPopularMovies() async {
    final responseData = await apiClient.getPopularMovies('/movie/popular');
    List<Movie> movies = [];
    movies = (responseData['results'] as List)
        .map((json) {
          return Movie.fromJson(json);
        })
        .cast<Movie>()
        .toList();
    return movies;
  }
}
