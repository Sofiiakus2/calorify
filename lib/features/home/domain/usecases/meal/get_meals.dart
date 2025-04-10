import 'package:calorify/features/home/domain/entities/meal.dart';
import 'package:calorify/features/home/domain/repositories/meal_repository.dart';

/// Use case for getting a meal from the repository.
class GetMeals{
  final MealRepository repository;

  ///Constructor
  GetMeals(this.repository);

  ///Executes the logic
  Future<List<Meal>> call(){
    return repository.getMeals();
  }
}
