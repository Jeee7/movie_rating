import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_rating/app.dart';
import 'package:movie_rating/model/movie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieItemAdapter());
  await Hive.openBox('watchlistBox');
  runApp(const MovieRatingApp());
}
