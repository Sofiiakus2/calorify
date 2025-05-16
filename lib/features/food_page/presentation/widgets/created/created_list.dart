import 'package:calorify/features/food_page/presentation/widgets/created/create_new_button.dart';
import 'package:flutter/material.dart';

class CreatedList extends StatelessWidget {
  const CreatedList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 0 + 1,
      itemBuilder: (context, index) {
        // if (index < state.sport.length) {
        //   final sport = state.sport[index];
        //   final sportModel = SportModel.fromEntity(sport);
        //
        //
        //   return ActivityCard(
        //     sport: sportModel,
        //   );
        // }
        // else {
          return CreateNewButton();
      //   }
       },
    );
  }
}
