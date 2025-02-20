import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';

import '../../../../models/eating_model.dart';
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
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 120,
        ),
        itemCount: meals.length + 1,
        itemBuilder: (context, index) {
          if (index < meals.length) {
            final meal = meals[index];
            return buildMealCard(
              meal: meal.meal,
              calories: meal.calories,
              icon: meal.iconName,
              color: meal.colorBlock,
              context: context,
            );
          } else {
            return GestureDetector(
              onTap: () {
                setState(() {
                  meals.add(EatingModel(
                    meal: 'Новий прийом',
                    calories: 0,
                    iconName: 'salad',
                    colorBlock: Colors.grey.shade200,
                  ));
                });
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
      ),
    );
  }
}
