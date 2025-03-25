import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/sport_model.dart';
import '../../../../state_management/sport/sport_state.dart';
import 'creating_new_sport/new_sport_alert.dart';

Widget buildActivityCard({
  required SportModel sport,
  required BuildContext context
}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: sport.colorBlock
    ),
    margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
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
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Center(
                  child: Image.asset('assets/icons/sport/${sport.iconName}.png'),
                ),
              ),              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    sport.name,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text('${sport.calories} ккал',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NewSportAlert(
                      editSport: sport,
                      onSportEdit: (act ) {
                        context.read<SportCubit>().removeSport(act.id);
                        context.read<SportCubit>().addSport(act);
                      },
                      onSportDelete: (act){
                        context.read<SportCubit>().removeSport(act.id);
                      },
                    );
                  },
                );
              },
              icon: Icon(Icons.mode_edit_outline_outlined, color: Colors.black,)
          )
        ],
      ),
    ),
  );
}
