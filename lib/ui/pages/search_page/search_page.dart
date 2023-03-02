import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/ui_theme/app_style.dart';

import '../../components/CurrentRegionItem/CurrentRegionItem.dart';
import '../../components/FavoriteList/FavoriteList.dart';
import '../../components/SearchAppBar/SearchAppBar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WeatherSearch(),
    );
  }
}

class WeatherSearch extends StatelessWidget {
  const WeatherSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                model.setBg(),
              ))),
      child: Column(children:  [
       const SearchAppBar(),
        const CurrentRegionItem(),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 25,left: 16),
            child: Text('Избраное',
            style: AppStyle.fontStyle.copyWith(
              fontSize: 16,
            fontWeight: FontWeight.w700),),
          ),
        ),
      
        const FavoriteList(),
        const SizedBox(height: 16,),
      ]),
    );
  }
}
