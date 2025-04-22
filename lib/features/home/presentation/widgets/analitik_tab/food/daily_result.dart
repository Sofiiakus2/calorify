import 'package:calorify/core/theme.dart';
import 'package:flutter/material.dart';

///daily result block
class DailyResult extends StatelessWidget {
  const DailyResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: appMainGrey,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text('ккал',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,),
              ),
              Text('1234',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Column(
            children: [
              Text('б',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,),
              ),
              Text('86',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Column(
            children: [
              Text('ж',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,),
              ),
              Text('34',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Column(
            children: [
              Text('в',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,),
              ),
              Text('200',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
