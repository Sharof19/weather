import 'package:hive/hive.dart';
part 'favorite_history.g.dart';

@HiveType(typeId: 0)
class FavoritteHistory {
  @HiveField(0)
  String cityName;
  @HiveField(1)
  String bg;
  @HiveField(2)
  int color;
  FavoritteHistory(this.cityName, this.bg, this.color);
  
}
