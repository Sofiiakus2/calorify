import 'package:awesome_notifications/awesome_notifications.dart';

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

}