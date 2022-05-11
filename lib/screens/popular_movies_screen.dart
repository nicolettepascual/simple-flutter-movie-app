import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:simple_movie_app/models/movie.dart';
import 'package:simple_movie_app/store/movie_store.dart';
import 'package:simple_movie_app/widgets/loading_widget.dart';
import 'package:simple_movie_app/widgets/movie_list_widget.dart';
import 'package:simple_movie_app/widgets/retry_widget.dart';

class PopularMovies extends StatefulHookWidget {
  const PopularMovies({Key? key}) : super(key: key);

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  MovieStore moviesStore = MovieStore();
  ObservableFuture<List<Movie>>? future;

  @override
  void initState() {
    super.initState();
    moviesStore.fetchPopularMovies();
    future = moviesStore.movieListFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        switch (future?.status) {
          case FutureStatus.pending:
            return LoadingWidget();

          case FutureStatus.rejected:
            return RetryWidget(_refresh);

          case FutureStatus.fulfilled:
            final List<Movie> latestMovies = future?.result;
            return MovieListWidget(
              movies: latestMovies,
              onRefresh: _refresh,
            );

          default:
            return Container();
        }
      },
    );
  }

  Future _refresh() => moviesStore.fetchPopularMovies();
}
