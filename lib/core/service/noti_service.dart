import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:calorify/features/noti_page/domain/entities/notification_model.dart';
import 'package:hive/hive.dart';

class NotiService{
  Future<void> scheduleNotification(int minutesDuration) async {
    // final now = DateTime.now();
    // final scheduledTime = now.add(Duration(minutes: minutesDuration));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Нагадування',
        body: 'Настав час пити воду!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationInterval(
          interval: Duration(minutes:minutesDuration),
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      repeats: true,
      preciseAlarm: true,
    ),
    );
  }

  Future<void> cancelAllScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }

  Future<void> catchNoti(ReceivedNotification receivedNotification) async{
    final box = Hive.box<MyNotificationModel>('notificationsBox');

    final newNotification = MyNotificationModel(
      title: receivedNotification.title ?? 'Без заголовку',
      body: receivedNotification.body ?? 'Без тексту',
      receivedAt: DateTime.now(),
    );

    await box.add(newNotification);
print('object');
  }
}