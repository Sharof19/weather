import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/domain/api/api.dart';
import 'package:weather_app/domain/hive/hive_boxes.dart';
import 'package:weather_app/domain/json_convertors/coord.dart';
import 'package:weather_app/domain/json_convertors/weathar_data.dart';
import 'package:weather_app/ui/resources/app_bg.dart';
import 'package:weather_app/ui/ui_theme/App_color.dart';

import '../hive/favorite_history.dart';

class WeatherProvider extends ChangeNotifier {
  Coord? _coords;
  Coord? get coords => _coords;
  WeatherData? weatherData;
  Current? current;
  TextEditingController searchController = TextEditingController();

  Future<WeatherData?> setUp({String? cityName}) async {
    final pref = await SharedPreferences.getInstance();
    // pref.clear();
    cityName = pref.getString('city_name');
    _coords = await Api.getCoords(cityName: cityName ?? 'Tashkent');
    weatherData = await Api.getWeather(coords);
    current = weatherData?.current;
    setSevenDays();
    return weatherData;
  }

  /* установка текущего города */
  void setCurrCity(BuildContext context, {String? cityName}) async {
    if (searchController.text != null && searchController.text != '') {
      cityName = searchController.text;
      final pref = await SharedPreferences.getInstance();
      await pref.setString('city_name', cityName);
      await setUp(cityName: pref.getString('city_name'))
          .then((value) => Navigator.pop(context))
          .then(
            (value) => searchController.clear(),
          );
      notifyListeners();
    }
  }

  String? currentTime;
  String setCurrentTime() {
    final getTime = (current?.dt ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000);
    currentTime = DateFormat('HH:mm a').format(setTime);
    return currentTime ?? 'Error';
  }

  String currentStatus = '';
  String setCurrentStatus() {
    currentStatus = current?.weather?[0].description ?? 'ads';
    return currentStatus;
  }

  String currentIconUrl = 'https://api.openweathermap.org/img/w/';
  String setIcon() {
    return '${currentIconUrl}${current?.weather?[0].icon}.png';
  }

  String? currentBg;

  String setBg() {
    int id = current?.weather?[0].id ?? -1;

    if (id == -1 || current?.sunset == null || current?.dt == null) {
      currentBg = AppBg.shinyDay;
    }

    try {
      if (current!.sunset! < current!.dt!) {
        if (id >= 200 && id <= 531) {
          AppColor.darkBlueColor = const Color(0xFFFFFFFF);
          AppColor.blackColor = const Color(0xFFFFFFFF);
          AppColor.iconColor = const Color(0xFFFFFFFF);

          currentBg = AppBg.rainyNight;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowNight;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogNight;
          AppColor.sevenDayBoxColor = const Color.fromRGBO(35, 35, 35, 0.5);
          AppColor.darkBlueColor = const Color(0xFFFFFFFF);
          AppColor.blackColor = const Color(0xFFFFFFFF);
          AppColor.iconColor = const Color(0xFFFFFFFF);
        } else if (id == 800) {
          currentBg = AppBg.shinyNight;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyNight;
        }
      } else {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyDay;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowDay;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogDay;
        } else if (id == 800) {
          currentBg = AppBg.shinyDay;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyDay;
        }
      }
    } catch (e) {
      return AppBg.shinyDay;
    }

    return currentBg ?? AppBg.shinyDay;
  }

  int kelvin = -273;
  int currentTemp = 0;
  int setCurrentTemp() {
    currentTemp = ((current?.temp ?? -kelvin) + kelvin).round();
    return currentTemp;
  }

  int maxTemp = 0;
  String setMaxTemp() {
    maxTemp = ((weatherData?.daily?[0].temp?.max ?? -kelvin) + kelvin).round();
    return maxTemp.toString();
  }

  int minTemp = 0;
  String setminTemp() {
    minTemp = ((weatherData?.daily?[0].temp?.min ?? -kelvin) + kelvin).round();
    return minTemp.toString();
  }

  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);

  final List<String> date = [];
  List<Daily> daily = [];
  void setSevenDays() {
    daily = weatherData!.daily!;
    for (var i = 0; i < daily.length; i++) {
      if (i == 0 && daily.isNotEmpty) {
        date.clear();
      }
      if (i == 0) {
        date.add('Сегодня');
      } else {
        var timeNum = daily[i].dt! * 1000;
        var itemDate = DateTime.fromMillisecondsSinceEpoch(timeNum);
        date.add(capitalize(DateFormat('EEEE', 'ru').format(itemDate)));
      }
    }
  }

  final String _iconUrlPath = 'http://openweathermap.org/img/wn/';
  String setDaylyIcons(int index) {
    final String getIcon = '${weatherData?.daily?[index].weather?[0].icon}';
    final String setIcon = '$_iconUrlPath$getIcon.png';
    return setIcon;
  }

  int dailyTemp = 0;
  int setDailyTemp(int index) {
    dailyTemp =
        ((weatherData?.daily?[index].temp?.morn ?? -kelvin) + kelvin).round();
    return dailyTemp;
  }

  int nightTemp = 0;
  int setNightTemp(int index) {
    nightTemp =
        ((weatherData?.daily?[index].temp?.night ?? -kelvin) + kelvin).round();
    return nightTemp;
  }

  List<dynamic> weatherValues = [];
  dynamic setValues(int index) {
    weatherValues.add(current?.windSpeed ?? 0);
    weatherValues
        .add(((current?.feelsLike ?? -kelvin) + kelvin).roundToDouble());
    weatherValues.add((current?.humidity ?? 0) / 1);
    weatherValues.add((current?.visibility ?? 0) / 1000);
    return weatherValues[index];
  }

  String sunRise = '';
  String setCurrentSunRise() {
    final getSunTime =
        (current?.sunrise ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunRise = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunRise = DateFormat('HH:mm a').format(setSunRise);
    return sunRise;
  }

  String sunSet = '';
  String setCurrentSunSet() {
    final getSunTime =
        (current?.sunrise ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunSet = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunSet = DateFormat('HH:mm a').format(setSunSet);
    return sunSet;
  }

  //фукция добавления к избранном
  Future<void> setFavorite(BuildContext context, {String? cityName}) async {
    var box = Hive.box<FavoritteHistory>(HiveBoxes.favoriteBox);

    box
        .add(
          FavoritteHistory(weatherData?.timezone ?? 'Eror',
              currentBg ?? AppBg.shinyDay, AppColor.darkBlueColor.value),
        )
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('город $cityName добавлен в избранный'),
            )));
  }

  //*****************
  /*udoleniya*/
  Future<void> deleteFav(int index) async {
    var box = Hive.box<FavoritteHistory>(HiveBoxes.favoriteBox);
    box.deleteAt(index);
  }
}
