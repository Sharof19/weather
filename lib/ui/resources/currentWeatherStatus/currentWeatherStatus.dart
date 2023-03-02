import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/ui_theme/App_color.dart';
import 'package:weather_app/ui/ui_theme/app_style.dart';

class CurrentWeatherStatus extends StatelessWidget {
  const CurrentWeatherStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(model.setIcon(),scale: 1.1,width: 50,),
        const SizedBox(width: 25,),
        Text(model.currentStatus,style: AppStyle.fontStyle.copyWith(
          color: AppColor.darkBlueColor,
          fontSize: 16,
        ),)
      ],
    );
  }
}
