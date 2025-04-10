import 'package:calorify/features/home/domain/entities/meal.dart';
import 'package:calorify/features/home/domain/repositories/meal_repository.dart';

class AddMeals{
  final MealRepository repository;

  AddMeals(this.repository);

  Future<void> call(Meal meal){
    return repository.addMeal(meal);
  }
}