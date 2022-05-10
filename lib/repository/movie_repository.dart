import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_movie_app/models/movie.dart';

class MoviesRepository {
  List<Movie> movies = [];

  Future getData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint('------Data: $data');
      movies = (data['results'] as List).map((json) {
        return Movie.fromJson(json);
      }).cast<Movie>().toList();
      return movies;
    } else {
      debugPrint("Error in URL");
    }
  }
}