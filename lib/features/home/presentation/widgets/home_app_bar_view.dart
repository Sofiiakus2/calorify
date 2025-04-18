import 'package:calorify/core/provider/user_provide.dart';
import 'package:calorify/core/theme.dart';
import 'package:calorify/features/home/presentation/widgets/calendar/date_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///home app bar
class HomeAppBarView extends StatelessWidget {
  ///
  const HomeAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: appMainGrey,
            child: const Icon(Icons.person_outline_rounded, size: 30, color: Colors.black,),
          ),
          const SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Привіт,',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                context.read<UserProvider>().user.name.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),

            ],
          ),
          const Expanded(child: SizedBox()),
          const DateBlock(),
        ],
      ),
    );
  }
}
