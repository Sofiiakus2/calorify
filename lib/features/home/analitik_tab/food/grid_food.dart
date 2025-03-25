import 'package:calorify/features/home/analitik_tab/food/creating_new_meal/new_meal_alert.dart';
import 'package:calorify/state_management/meal/meal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'food_meal_card.dart';

class GridFood extends StatefulWidget {
  const GridFood({super.key});

  @override
  State<GridFood> createState() => _GridFoodState();
}

class _GridFoodState extends State<GridFood> {

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<MealCubit, MealState>(
          builder: (context, state){
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 120,
              ),
              itemCount: state.meals.length + 1,
              itemBuilder: (context, index) {
                if (index < state.meals.length) {
                  final meal = state.meals[index];
                  return buildMealCard(
                    meal: meal.meal,
                    calories: meal.calories,
                    icon: meal.iconName,
                    color: meal.colorBlock,
                    context: context,
                  );
                } else if(state.meals.length < 6 ) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NewMealAlert(
                            onMealAdded: (meal){
                              context.read<MealCubit>().addMeal(meal);
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade200,
                      ),
                      child: const Icon(Icons.add, size: 50, color: Colors.black),
                    ),
                  );
                }
              },
            );
          }),
    );
  }
}
