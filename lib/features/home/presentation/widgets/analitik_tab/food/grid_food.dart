import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:calorify/features/home/presentation/bloc/meal/meal_state.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/food/creating_new_meal/new_meal_alert.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/food/daily_result.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/food/food_meal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Grid with shows meals
class GridFood extends StatefulWidget {
  ///
  const GridFood({super.key});

  @override
  State<GridFood> createState() => _GridFoodState();
}

class _GridFoodState extends State<GridFood> {

  @override
  Widget build(BuildContext context) {
    return  Padding( 
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const DailyResult(),
          Flexible(
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
                        final mealModel = MealModel.fromEntity(meal);

                        return buildMealCard(
                          meal: mealModel.meal,
                          calories: mealModel.calories,
                          icon: mealModel.iconName,
                          color: mealModel.colorBlock,
                          context: context,
                        );
                      } else if(state.meals.length < 6 ) {
                        return GestureDetector(
                          onTap: () {
                            final cubit = context.read<MealCubit>();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NewMealAlert(
                                  onMealAdded: (meal){
                                    cubit.add(meal);
                                  },
                                );
                              },
                            );
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey.shade200,
                            ),
                            child: const Icon(Icons.add, size: 50, color: Colors.black),
                          ),
                        );
                      }

                      return null;
                    },
                  );
                },
            ),
          ),
        ],
      ),
    );
  }
}
