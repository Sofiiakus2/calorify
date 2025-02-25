import 'package:calorify/features/home/analitik_tab/sport/creating_new_sport/new_sport_alert.dart';
import 'package:calorify/models/sport_model.dart';
import 'package:calorify/state_management/sport/sport_state.dart';
import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'activity_card.dart';

class GridSport extends StatefulWidget {
  const GridSport({super.key});

  @override
  State<GridSport> createState() => _GridSportState();
}

class _GridSportState extends State<GridSport> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SportCubit, SportState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.activity.length + 1,
            itemBuilder: (context, index) {
              if (index < state.activity.length) {
                final activity = state.activity[index];
                return buildActivityCard(
                  name: activity.name,
                  calories: activity.calories,
                  icon: activity.iconName,
                  color: activity.colorBlock,
                  context: context,
                );
              }
              else {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NewSportAlert(
                          onSportAdded: (act ) {
                            context.read<SportCubit>().addSport(act);
                          },

                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.grey.shade200
                    ),
                    margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.add, color: Colors.black,),
                              SizedBox(width: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Додати Активність',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              }
            }
        );
      }
    );
  }
}
