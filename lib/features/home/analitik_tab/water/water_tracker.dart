import 'package:calorify/features/home/analitik_tab/water/water_view.dart';
import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Вам рекомендовано 8 стаканів води на день',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: 15,),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: buildWaterDrops(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                'Змінити кількість',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
