import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/domain/hive/hive_boxes.dart';

import 'domain/hive/favorite_history.dart';
import 'weather_app.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await Hive.initFlutter();
  Hive.registerAdapter(FavoritteHistoryAdapter());
  await Hive.openBox<FavoritteHistory>(HiveBoxes.favoriteBox);
  await dotenv.load(fileName: '.env');
  runApp(
    const WeatherAPP(),
  );
}
