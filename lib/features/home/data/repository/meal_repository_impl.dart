import 'package:calorify/features/home/domain/entities/meal.dart';

import 'package:calorify/features/home/domain/repositories/meal_repository.dart';

///Meal Repository Implementation
class MealRepositoryImpl extends MealRepository{
  final List<Meal> _meals = [
    Meal(meal: MealType.breakfast, calories: 0,
        iconName: 'pancakes', isTodayOnly: false, products: [],),
    Meal(meal: MealType.lunch, calories: 0,
        iconName: 'salad', isTodayOnly: false, products: [],),
    Meal(meal: MealType.dinner, calories: 0,
        iconName: 'soup', isTodayOnly: false, products: [],),
    Meal(meal: MealType.snack, calories: 0,
        iconName: 'pretzel', isTodayOnly: false, products: [],),
  ];

  @override
  Future<List<Meal>> getMeals() async {
    return _meals;
  }

  @override
  Future<void> addMeal(Meal meal) async {
    _meals.add(meal);
  }
}