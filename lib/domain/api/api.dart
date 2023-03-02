import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/domain/json_convertors/coord.dart';
import 'package:weather_app/domain/json_convertors/weathar_data.dart';

abstract class Api {
  static final _client = HttpClient();
  static const scheme = 'http';
  static const host = 'api.openweathermap.org';
  static final api = dotenv.get('API_KEY');

// https://api.openweathermap.org/data/2.5/weather?q=London&appid=8a00668c6b556cefecfd7888df2a5aff

  static Future<Coord> getCoords({String cityName = 'tashkent'}) async {
    const path = 'data/2.5/weather';
    Uri url = Uri(scheme: scheme, host: host, path: path, queryParameters: {
      'q': cityName,
      'appid': api,
      'lang': 'ru',
    });

    try {
      final data = await _jsonRequest(url);
      final coords = Coord.fromJson(data);
      return coords;
    } catch (e) {
      final data = await _jsonRequest(url);
      final coords = Coord.fromJson(data);
      return coords;
    }
  }

  static Future<WeatherData?> getWeather(Coord? coord) async {
    if (coord != null) {
      const weatherPath = 'data/2.5/onecall';
      Uri url = Uri(
        scheme: scheme,
        host: host,
        path: weatherPath,
        queryParameters: {
          'lat': coord.lat.toString(),
          'lon': coord.lon.toString(),
          'exclude': 'hourly,minutely',
          'appid': api,
          'lang': 'ru',
        },
      );
      print(url);
      final data = await _jsonRequest(url);
      final weatherData = WeatherData.fromJson(data);

      return weatherData;
    }
    return null;
  }

  static Future<Map<String, dynamic>> _jsonRequest(Uri url) async {
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();

      final json = await response.transform(utf8.decoder).toList();
      final jsonString = json.join();
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      return data;
    } catch (e) {
      print(e);
    }
    return {};
  }
}
