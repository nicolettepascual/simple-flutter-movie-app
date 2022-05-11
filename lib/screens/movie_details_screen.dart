import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import 'package:simple_movie_app/configs/config_env.dart';
import 'package:simple_movie_app/models/movie.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:simple_movie_app/store/movie_store.dart';
import 'package:simple_movie_app/widgets/loading_widget.dart';
import 'package:simple_movie_app/widgets/retry_widget.dart';

class MovieDetailsScreen extends StatefulHookWidget {
  final int movieId;
  final String title;
  const MovieDetailsScreen(this.movieId, this.title, {Key? key})
      : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieStore moviesStore = MovieStore();
  ObservableFuture<Movie>? future;

  final String posterUrl =
      GlobalConfiguration().getValue(Config.POSTER_URL) as String;

  @override
  void initState() {
    super.initState();
    moviesStore.fetchMovie(widget.movieId);
    future = moviesStore.movieFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (_) {
          switch (future?.status) {
            case FutureStatus.pending:
              return LoadingWidget();

            case FutureStatus.rejected:
              return RetryWidget(_refresh);

            case FutureStatus.fulfilled:
              final Movie movie = future?.result;
              return SingleChildScrollView(
                child: Center(
                    child: Column(
                  children: [
                    Image.network(
                      '$posterUrl${movie.backdrop}',
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Release Date: ${DateFormat('d MMMM y').format(DateTime.parse(movie.releaseDate))}',
                          textAlign: TextAlign.start,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(movie.overview)),
                  ],
                )),
              );

            default:
              return Container();
          }
        },
      ),
    );
  }

  Future _refresh() => moviesStore.fetchMovie(widget.movieId);
}
