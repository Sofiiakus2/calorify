
import 'package:calorify/features/home/domain/entities/meal.dart';

abstract class MealRepository{
  Future<List<Meal>> getMeals();
  Future<void> addMeal(Meal meal);
}