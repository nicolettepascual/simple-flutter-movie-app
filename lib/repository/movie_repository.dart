import 'dart:convert';

import 'package:simple_movie_app/api/ApiClient.dart';
import 'package:simple_movie_app/models/movie.dart';

class MoviesRepository {
  final ApiClient apiClient = ApiClient();

  Future getMovie(int movieId) async {
    final responseData = await apiClient.getPopularMovies('/movie/$movieId');
    Movie movie = Movie.fromJson(json.decode(json.encode(responseData)) as Map<String, dynamic>);
    return movie;
  }

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
