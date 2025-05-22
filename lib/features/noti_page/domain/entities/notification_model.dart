import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 2)
class MyNotificationModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String body;

  @HiveField(2)
  DateTime receivedAt;

  MyNotificationModel({
    required this.title,
    required this.body,
    required this.receivedAt,
  });
}
