import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/sport/sport_state.dart';
import 'activity_card.dart';
import 'creating_new_sport/new_sport_alert.dart';

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
                  sport: state.activity[index],
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
