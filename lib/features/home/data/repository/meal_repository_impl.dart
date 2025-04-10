import 'package:calorify/features/home/domain/entities/meal.dart';

import '../../domain/repositories/meal_repository.dart';

class MealRepositoryImpl extends MealRepository{
  final List<Meal> _meals = [
    Meal(meal: 'Сніданок', calories: 243, iconName: 'pancakes', isTodayOnly: false),
    Meal(meal: 'Обід', calories: 335, iconName: 'salad', isTodayOnly: false),
    Meal(meal: 'Вечеря', calories: 0, iconName: 'soup', isTodayOnly: false),
    Meal(meal: 'Перекус', calories: 0, iconName: 'pretzel', isTodayOnly: false),
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