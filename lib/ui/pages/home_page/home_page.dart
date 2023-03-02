import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/components/SunriseSunsetWidget/SunriseSunsetWidget.dart';
import 'package:weather_app/ui/components/WeatherInfoItems/WeatherInfoItems.dart';
import 'package:weather_app/ui/components/maxMinTemp/maxMinTemp.dart';
import 'package:weather_app/ui/ui_theme/App_color.dart';
import 'package:weather_app/ui/ui_theme/app_style.dart';

import '../../components/SavenDaysweatherWidget/SavenDaysweatherWidget.dart';
import '../../components/weather_appbar/weather_appbar.dart';
import '../../resources/currentWeatherStatus/currentWeatherStatus.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Provider.of<WeatherProvider>(context).setUp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const HomePageWidget();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(model.setBg()), fit: BoxFit.cover),
      ),
      child: Column(children: [
        const WeatherAppBar(),
        Expanded(
            child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          children: [
            Text(
              model.setCurrentTime(),
              textAlign: TextAlign.center,
              style: AppStyle.fontStyle.copyWith(
                fontSize: 14,
                color: AppColor.darkBlueColor,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            const CurrentWeatherStatus(),
            const SizedBox(
              height: 36,
            ),
            Text(
              '${model.setCurrentTemp()} °C',
              textAlign: TextAlign.center,
              style: AppStyle.fontStyle.copyWith(
                fontSize: 90,
                color: AppColor.blackColor,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            const MaxMinTemp(),
            const SizedBox(
              height: 36,
            ),
            const SavenDaysweatherWidget(),
            const SizedBox(
              height: 20,
            ),
           const SizedBox(
              height: 380,
            child:WeatherInfoItems(),),
            const SizedBox(
              height: 30,
            ),
            const SunriseSunsetWidget(),
          ],
        )),
      ]),
    );
  }
}
