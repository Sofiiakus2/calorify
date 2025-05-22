// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyNotificationModelAdapter extends TypeAdapter<MyNotificationModel> {
  @override
  final int typeId = 2;

  @override
  MyNotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyNotificationModel(
      title: fields[0] as String,
      body: fields[1] as String,
      receivedAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MyNotificationModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.receivedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyNotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
