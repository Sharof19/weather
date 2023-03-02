// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritteHistoryAdapter extends TypeAdapter<FavoritteHistory> {
  @override
  final int typeId = 0;

  @override
  FavoritteHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoritteHistory(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FavoritteHistory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.bg)
      ..writeByte(2)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritteHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
