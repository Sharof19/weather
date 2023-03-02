import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/hive/favorite_history.dart';
import 'package:weather_app/domain/hive/hive_boxes.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/resources/app_bg.dart';
import 'package:weather_app/ui/ui_theme/App_color.dart';
import 'package:weather_app/ui/ui_theme/app_style.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<Box<FavoritteHistory>>(
        valueListenable:
            Hive.box<FavoritteHistory>(HiveBoxes.favoriteBox).listenable(),
        builder: (context, value, _) {
          return ListView.separated(
            itemBuilder: (context, i) {
              return FavoriteCard(
                index: i,
                value: value,
              );
            },
            separatorBuilder: (context, i) => const SizedBox(
              height: 16,
            ),
            itemCount: value.length,
          );
        },
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    super.key,
    required this.index,
    required this.value,
  });
  final int index;
  final Box<FavoritteHistory> value;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
            image: AssetImage(value.getAt(index)?.bg ?? AppBg.shinyDay)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CurrentFavoriteItem(
            index: index,
            value: value,
          ),
          IconButton(
              onPressed: () {
                model.deleteFav(index);
              },
              icon: Icon(Icons.delete, color: AppColor.redColor))
        ],
      ),
    );
  }
}

class CurrentFavoriteItem extends StatelessWidget {
  const CurrentFavoriteItem({
    super.key,
    required this.index,
    required this.value,
  });
  final int index;
  final Box<FavoritteHistory> value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Т,екущее мусто',
          style: AppStyle.fontStyle.copyWith(fontSize: 12),
        ),
        Text(
          value.getAt(index)?.cityName ?? 'Eror',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          value.getAt(index)?.cityName ?? 'Eror',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
