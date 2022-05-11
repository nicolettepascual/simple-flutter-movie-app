import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:simple_movie_app/models/movie.dart';
import 'package:simple_movie_app/store/movie_store.dart';

class LatestMovies extends StatefulHookWidget {
  const LatestMovies({Key? key}) : super(key: key);

  @override
  State<LatestMovies> createState() => _LatestMoviesState();
}

class _LatestMoviesState extends State<LatestMovies> {
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
    /** TODO: Create separate reusable widget */
    return Observer(
      builder: (_) {
        switch (future?.status) {
          case FutureStatus.pending:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case FutureStatus.rejected:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Failed to load items.',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: const Text('Tap to retry'),
                    onPressed: _refresh,
                  )
                ],
              ),
            );
          case FutureStatus.fulfilled:
            final List<Movie> latestMovies = future?.result;
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: latestMovies.length,
                itemBuilder: (context, index) {
                  final latestMovie = latestMovies[index];
                  return ExpansionTile(
                    title: Text(
                      latestMovie.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    children: <Widget>[Text(latestMovie.overview)],
                  );
                },
              ),
            );
          default: return Container();
        }
      },
    );
  }

  Future _refresh() => moviesStore.fetchPopularMovies();
}
