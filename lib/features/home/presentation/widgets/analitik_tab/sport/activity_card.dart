import 'package:calorify/features/home/data/models/sport_model.dart';
import 'package:calorify/features/home/presentation/bloc/sport/sport_state.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/sport/creating_new_sport/new_sport_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Sport card
class ActivityCard extends StatelessWidget {
  final SportModel sport;

  ///
  const ActivityCard({
    required this.sport, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: sport.colorBlock,
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
                    child: Image.asset('assets/icons/sport/${sport.iconName}.png'),
                  ),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      sport.name,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      '${sport.calories} ккал',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                final cubit = context.read<SportCubit>();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NewSportAlert(
                      editSport: sport,
                      onSportEdit: (activity) {
                        cubit.delete(activity);
                        cubit.add(activity);
                      },
                      onSportDelete: (activity) {
                        cubit.delete(activity);
                      },
                    );
                  },
                );
              },
              icon: const Icon(Icons.mode_edit_outline_outlined, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
