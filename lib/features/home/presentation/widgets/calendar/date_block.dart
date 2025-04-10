import 'package:flutter/material.dart';

import '../../../../../core/theme.dart';
import 'calendar_overlay.dart';

class DateBlock extends StatelessWidget {
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
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '13',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              'Лют',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
