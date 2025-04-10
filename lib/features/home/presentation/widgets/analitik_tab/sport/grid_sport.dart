import 'package:calorify/features/home/data/models/sport_model.dart';
import 'package:calorify/features/home/presentation/bloc/sport/sport_state.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/sport/activity_card.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/sport/creating_new_sport/new_sport_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Grid for showing ssport
class GridSport extends StatefulWidget {
  ///
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
          itemCount: state.sport.length + 1,
            itemBuilder: (context, index) {
              if (index < state.sport.length) {
                final sport = state.sport[index];
                final sportModel = SportModel.fromEntity(sport);


                return ActivityCard(
                  sport: sportModel,
                );
              }
              else {
                return GestureDetector(
                  onTap: () {
                    final cubit = context.read<SportCubit>();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NewSportAlert(
                          onSportAdded: (activity ) {
                            cubit.add(activity);
                          },

                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                        color: Colors.grey.shade200,
                    ),
                    margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
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
            },
        );
      },
    );
  }
}
