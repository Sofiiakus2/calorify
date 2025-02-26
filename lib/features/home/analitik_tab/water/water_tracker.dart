import 'package:calorify/features/home/analitik_tab/water/time_dropdown.dart';
import 'package:calorify/features/home/analitik_tab/water/water_view.dart';
import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../state_management/water/water_state.dart';
import '../../../shared_widgets/custom_toggle.dart';

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  bool isRemindToDrink = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Вода за сьогодні',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          BlocBuilder<WaterCubit, WaterState>(
            builder: (context, state) {
              return Text('Ви випили ${state.filledCount} стакани води з ${state.glassesCount}' ,
                style: Theme.of(context).textTheme.bodySmall,);
            },
          ),
          SizedBox(height: 15,),
          WaterDropsScreen(),
          SizedBox(height: 15,),
          Text('Сповіщати',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
            child: Row(
              children: [
                CustomToggle(
                  onActiveChange: (value){
                    setState(() {
                      isRemindToDrink = value;
                    });
                  },
                ),
                Text(' Нагадувати пити воду' ,
                  style: Theme.of(context).textTheme.bodySmall,),
      ],
            ),

          ),
          if(isRemindToDrink)
          TimeDropdown()
        ],
      ),
    );
  }
}
