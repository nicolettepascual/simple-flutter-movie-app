// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:simple_movie_app/models/movie.dart';
import 'package:simple_movie_app/widgets/movie_poster_widget.dart';

class MovieListWidget extends StatefulHookWidget {
  final List<Movie> movies;
  final Function onRefresh;

  const MovieListWidget({required this.movies, required this.onRefresh});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => widget.onRefresh(),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.6),
          itemCount: widget.movies.length,
          itemBuilder: (context, index) {
            final latestMovie = widget.movies[index];
            return GridTile(child: MoviePosterWidget(latestMovie));
          }),
    );
  }
}
