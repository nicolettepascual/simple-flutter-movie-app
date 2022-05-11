import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:simple_movie_app/configs/config_env.dart';

class ApiClient {
  final http.Client httpClient = http.Client();

  static final String serverUrl =
      GlobalConfiguration().getValue(Config.SERVER_URL) as String;
  static final String apiToken =
      GlobalConfiguration().getValue(Config.API_TOKEN) as String;
      

  Future<http.Response> _get(endpoint) async {
    debugPrint("GET: $endpoint");
    final Uri uri = Uri.https(serverUrl, '/3$endpoint', {
      'api_key' : apiToken,
      'language': 'en-US'
    });

    /// FIXME: Add timeout
    final response = await httpClient.get(uri);
    return response;
  }

    Future getPopularMovies(String endpoint) async {
    final response = await _get(endpoint);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      debugPrint("Error in URL");
    }
  }

  Future getMovie(String endpoint) async {
    final response = await _get(endpoint);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint('Movie: $data');
      return data;
    } else {
      debugPrint("Error in URL");
    }
  }
}
