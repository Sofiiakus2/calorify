
import 'package:calorify/features/home/domain/entities/meal.dart';
import 'package:calorify/features/home/domain/repositories/meal_repository.dart';

class GetMeals{
  final MealRepository repository;

  GetMeals(this.repository);

  Future<List<Meal>> call(){
    return repository.getMeals();
  }
}