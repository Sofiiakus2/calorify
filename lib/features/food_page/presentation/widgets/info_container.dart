import 'package:calorify/core/theme.dart';
import 'package:flutter/material.dart';

///
class InfoContainer extends StatelessWidget {
  final String name;
  final double count;

  ///constructor
  const InfoContainer({
    required this.name,
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: const BoxDecoration(
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
