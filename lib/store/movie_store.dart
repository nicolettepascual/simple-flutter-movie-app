import 'package:mobx/mobx.dart';
import 'package:simple_movie_app/models/movie.dart';
import 'package:simple_movie_app/repository/movie_repository.dart';

part 'movie_store.g.dart';

class MovieStore = _MovieStore with _$MovieStore;

abstract class _MovieStore with Store {
  final MoviesRepository httpClient = MoviesRepository();

  @observable
  ObservableFuture<List<Movie>>? movieListFuture;

  @action
  Future fetchPopularMovies() => movieListFuture = ObservableFuture(httpClient
      .getPopularMovies()
      .then((popularMovies) => popularMovies));
}
