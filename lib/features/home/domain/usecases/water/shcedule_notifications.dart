
import 'package:calorify/core/service/noti_service.dart';

class ScheduleNotifications{
  final NotiService _service;

  ScheduleNotifications(this._service);

  Future<void> call(int minutes){
    return _service.scheduleNotification(minutes);
  }
}