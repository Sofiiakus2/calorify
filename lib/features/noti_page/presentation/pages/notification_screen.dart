import 'package:calorify/core/theme.dart';
import 'package:calorify/features/noti_page/domain/entities/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<MyNotificationModel>('notificationsBox');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Історія сповіщень',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<MyNotificationModel> box, _) {
          final notifications = box.values.toList().reversed.toList();
          if (notifications.isEmpty) {
            return const Center(child: Text('Немає сповіщень'));
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final noti = notifications[index];

              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: getRandomLightColor(),
                ),
                margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Center(
                              child: Image.asset('assets/icons/bell.png'),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                noti.title,
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              Text(
                                noti.body,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(width: 100,),
                          Text(
                            '${noti.receivedAt.hour}:${noti.receivedAt.minute.toString().padLeft(2, '0')}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              );
              //   ListTile(
              //   title: Text(noti.title),
              //   subtitle: Text(noti.body),
              //   trailing: Text(
              //     '${noti.receivedAt.hour}:${noti.receivedAt.minute.toString().padLeft(2, '0')}',
              //     style: const TextStyle(fontSize: 12),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
