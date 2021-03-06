import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_movie_app/configs/config_env.dart';
import 'package:simple_movie_app/screens/home_screen.dart';

void main() {
  Config.loadConfig();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Movies App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(title: 'Movies App'),
    );
  }
}
