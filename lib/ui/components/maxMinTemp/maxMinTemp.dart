import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/ui_theme/App_color.dart';
import 'package:weather_app/ui/ui_theme/app_style.dart';

class MaxMinTemp extends StatelessWidget {
  const MaxMinTemp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/max_temp.svg',
          color: AppColor.redColor,
        ),
        Text(
          '\t${model.setMaxTemp()}°',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 25,
          ),
        ),
        const SizedBox(
          width: 65,
        ),
        SvgPicture.asset(
          'assets/icons/min_temp.svg',
          color: AppColor.blueColor,
        ),
        Text(
          '\t${model.setminTemp()}°',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 25,
          ),
        )
      ],
    );
  }
}
