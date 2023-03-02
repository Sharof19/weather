import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/ui_theme/App_color.dart';
import 'package:weather_app/ui/ui_theme/app_style.dart';

class WeatherInfoItems extends StatelessWidget {
  const WeatherInfoItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
      itemCount: 4,
      itemBuilder: (context, i) {
        return SizedBox(
          width: 181,
          height: 160,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: AppColor.sevenDayBoxColor,
            child: ListTile(
              leading: SvgPicture.asset(WeatherInfoIcons.weatherInfoIcons[i],
              color: AppColor.iconColor,
              ),
              title: Text('${model.setValues(i)} ${WeatherInfoUnits.weatherInfoUnits[i]}',
              style: AppStyle.fontStyle.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColor.blackColor,
                fontSize: 14,
              ),
              ),
              subtitle: Text(
                WeatherInfoDescription.weatherInfoDescription[i],
                style: AppStyle.fontStyle.copyWith(
                  fontSize: 10,
                  color: AppColor.blackColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class WeatherInfoIcons {
  static List<String> weatherInfoIcons = [
    'assets/icons/speed.svg',
    'assets/icons/glasses.svg',
    'assets/icons/raindrops.svg',
    'assets/icons/termometr.svg',
  ];
}
class WeatherInfoDescription {
  static List<String> weatherInfoDescription = [
    'скорость ветра',
    'ошущается',
    'влажность',
    'видимость',
  ];
}
class WeatherInfoUnits {
  static List<String> weatherInfoUnits = [
    'км/ч',
    '°',
    '%',
    'км/ч',
  ];
}
