import 'package:calorify/core/theme.dart';
import 'package:calorify/features/home/presentation/widgets/calendar/calendar_overlay.dart';
import 'package:flutter/material.dart';

///date block
class DateBlock extends StatelessWidget {
  ///
  const DateBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: 'CalendarOverlay',
            barrierColor: Colors.black54,
            pageBuilder: (context, anim, secAnim) {
              return const CalendarOverlay();
            },
          );
      },
      child: Container(
        height: 60,
        width: 50,
        decoration: BoxDecoration(
            color: appMainGrey,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateTime.now().day.toString(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              'КВІ',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
