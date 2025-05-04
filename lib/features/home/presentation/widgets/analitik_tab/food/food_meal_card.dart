import 'package:calorify/core/provider/bottom_nav_provider.dart';
import 'package:calorify/core/provider/selected_meal_provider.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///meal card view
class MealCard extends StatelessWidget {
  final MealModel mealModel;
  final int calories;
  final String icon;
  final Color color;

  ///constructor
  const MealCard({
    super.key,
    required this.mealModel,
    required this.calories,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    child: Image.asset('assets/icons/food/$icon.png'),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '$calories ккал',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mealModel.meal.name.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  onPressed: () {
                    context.read<SelectedMealProvider>().selectMeal(mealModel);
                    if (context.read<BottomNavProvider>().currentIndex != 1) {
                      context.read<BottomNavProvider>().changeTab(1);
                    }
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
