import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mobx/mobx.dart';
import 'package:simple_movie_app/configs/config_env.dart';
import 'package:simple_movie_app/models/movie.dart';
import 'package:simple_movie_app/repository/movie_repository.dart';

part 'movie_store.g.dart';

class MovieStore = _MovieStore with _$MovieStore;

abstract class _MovieStore with Store {
  final MoviesRepository httpClient = MoviesRepository();

  /// TODO: Create separate http client file to handle http calls
  static final String serverUrl =
      GlobalConfiguration().getValue(Config.SERVER_URL) as String;
  static final String apiToken =
      GlobalConfiguration().getValue(Config.API_TOKEN) as String;

  @observable
  ObservableFuture<List<Movie>>? movieListFuture;

  @action
  Future fetchMovies() => movieListFuture = ObservableFuture(httpClient
  /// TODO: Create separate http client file to handle http calls
  /// TODO: handle different url path
      .getData(
          '$serverUrl/movie/popular?api_key=$apiToken&language=en-US&page=1')
      .then((users) => users));

  Future<void> getMovies() async {
    await fetchMovies();
  }
}
