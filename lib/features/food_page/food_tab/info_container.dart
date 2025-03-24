import 'package:flutter/material.dart';

import '../../../theme.dart';

class InfoContainer extends StatelessWidget {
  final String name;
  final double count;
  const InfoContainer({super.key, required this.name, required this.count});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
              Radius.circular(20)
          ),
        ),
        child: Column(
          children: [
            Text(name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(count.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
