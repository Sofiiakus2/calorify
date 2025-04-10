import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import 'calendar/date_block.dart';

class HomeAppBarView extends StatelessWidget {
  const HomeAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: appMainGrey,
            child: Icon(Icons.person_outline_rounded, size: 30, color: Colors.black,),
          ),
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Привіт,',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'Анастасія',
                style: Theme.of(context).textTheme.titleSmall,
              ),

            ],
          ),
          Expanded(child: SizedBox()),
          DateBlock()
        ],
      ),
    );
  }
}
