import 'package:flutter/material.dart';

import '../../../../theme.dart';

class DateBlock extends StatelessWidget {
  const DateBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
