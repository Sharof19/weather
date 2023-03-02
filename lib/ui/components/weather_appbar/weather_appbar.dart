import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/routes/app_routes.dart';
import 'package:weather_app/ui/ui_theme/App_color.dart';
import 'package:weather_app/ui/ui_theme/app_style.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WeatherAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return SafeArea(
        child: Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 150,
          ),
          const Icon(Icons.location_on),
          GestureDetector(
            onDoubleTap: () {
              model.setFavorite(
                context,
                cityName: model.weatherData?.timezone,
              );
            },
            child: Center(
              child: Text(
                '${model.weatherData?.timezone}',
                style: AppStyle.fontStyle,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.search);
              },
              icon: Icon(
                Icons.add,
                color: AppColor.darkBlueColor,
              ))
        ],
      ),
    ));
  }

  @override
  Size get preferredSize => throw const SizedBox(
        height: 20,
      );
}
