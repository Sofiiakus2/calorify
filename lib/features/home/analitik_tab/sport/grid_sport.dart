import 'package:calorify/models/sport_model.dart';
import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';

import 'activity_card.dart';

class GridSport extends StatefulWidget {
  const GridSport({super.key});

  @override
  State<GridSport> createState() => _GridSportState();
}

class _GridSportState extends State<GridSport> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length + 1,
        itemBuilder: (context, index) {
          if (index < activities.length) {
            final activity = activities[index];
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
                setState(() {
                  activities.add(SportModel(
                    name: 'Активність',
                    calories: 0,
                    iconName: 'salad',
                    colorBlock: Colors.grey.shade200,
                  ));
                });
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
}
