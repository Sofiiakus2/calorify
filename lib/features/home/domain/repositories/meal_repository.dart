import 'package:calorify/features/home/domain/entities/meal.dart';

///Meal repository
abstract class MealRepository{
  ///method for getting meal list
  Future<List<Meal>> getMeals();

  ///method for adding new meal to the list
  Future<void> addMeal(Meal meal);
}
