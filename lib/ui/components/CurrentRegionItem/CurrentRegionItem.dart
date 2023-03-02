import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/ui_theme/App_color.dart';
import 'package:weather_app/ui/ui_theme/app_style.dart';

class CurrentRegionItem extends StatelessWidget {
  const CurrentRegionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 382,
        height: 96,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              model.setBg(),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CurrentTimeZone(
            currentCity: model.weatherData?.timezone,
            currentZone:model.weatherData?.timezone ,
            ),
            CurrentTemp(icon: model.setIcon(),
            currenTemp: model.setCurrentTemp(),),
          ],
        ),
      ),
    );
  }
}

class CurrentTimeZone extends StatelessWidget {
  const CurrentTimeZone(
      {super.key, required this.currentCity, required this.currentZone});
  final String? currentCity, currentZone;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Текущее место',
          style: AppStyle.fontStyle.copyWith(
            color: AppColor.blackColor,
            fontSize: 12,
          ),
        ),
        Text(
          currentZone ?? 'Error',
          style: AppStyle.fontStyle.copyWith(
            color: AppColor.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          currentCity ?? 'Error',
          style: AppStyle.fontStyle.copyWith(
            color: AppColor.blackColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class CurrentTemp extends StatelessWidget {
  const CurrentTemp({super.key,
  required this.currenTemp,
  required this.icon});
  final String icon;
  final int currenTemp;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(icon),
        Text('$currenTemp °C',
        style: AppStyle.fontStyle.copyWith(
          fontSize: 18,
          color: AppColor.blackColor
        ),)
      ],
    );
  }
}
