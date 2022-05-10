// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:simple_movie_app/configs/debug_env.dart';

// ignore_for_file: non_constant_identifier_names
class Config {
  static const String SERVER_URL = 'SERVER_URL';
  static const String API_TOKEN = 'API_TOKEN';

  static void loadConfig() {
    GlobalConfiguration().loadFromMap(debugEnv);
  }
}
