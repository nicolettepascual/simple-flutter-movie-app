import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:simple_movie_app/configs/config_env.dart';
import 'package:simple_movie_app/models/movie.dart';
import 'package:simple_movie_app/screens/movie_details_screen.dart';

class MoviePosterWidget extends HookWidget {
  final Movie movie;

  const MoviePosterWidget(this.movie);
  
  @override
  Widget build(BuildContext context) {
    final String posterUrl =
      GlobalConfiguration().getValue(Config.POSTER_URL) as String;

    return Card(
      elevation: 2.0,
      child: InkWell(
        highlightColor: Colors.white.withAlpha(30),
        splashColor: Colors.white.withAlpha(20),
        child: Image.network(
          '$posterUrl${movie.poster}',
          fit: BoxFit.fill,
        ),
        onTap: () {
          debugPrint('${movie.id} ${movie.title}');
          Get.to(() => MovieDetailsScreen(movie.id, movie.title));
        },
      ),
    );
  }
}
