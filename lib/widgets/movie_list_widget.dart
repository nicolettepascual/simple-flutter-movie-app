// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:simple_movie_app/models/movie.dart';

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
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final latestMovie = widget.movies[index];
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
  }
}
