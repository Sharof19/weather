import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/ui_theme/App_color.dart';
import 'package:weather_app/ui/ui_theme/app_style.dart';

class SunriseSunsetWidget extends StatelessWidget {
  const SunriseSunsetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.all(40),
      width: MediaQuery.of(context).size.width,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.sevenDayBoxColor,
      ),
      child: Row(children: [
        RowItemWidget(icon: 'assets/icons/sunrise.svg', text: 'Восход ${model.setCurrentSunRise()}'),
       const SizedBox(width: 20,),
        RowItemWidget(icon: 'assets/icons/sunset.svg', text: 'Восход ${model.setCurrentSunSet()}'),
      ]),
    );
  }
}

class RowItemWidget extends StatelessWidget {
  const RowItemWidget({
    super.key,
    required this.icon,
    required this.text,
  });
  final String icon, text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          color: AppColor.iconColor,
        ),
        
        const SizedBox(height: 20,),
        Text(text,style: AppStyle.fontStyle.copyWith(
          color: AppColor.nightTempColor,
          fontSize: 16,
        ),)
      ],
    );
  }
}
