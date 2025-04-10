import 'package:calorify/features/home/domain/entities/meal.dart';
import 'package:calorify/features/home/domain/repositories/meal_repository.dart';

///usecase for adding meal
class AddMeals{
  final MealRepository repository;

  ///Constructor for the `AddMeals` use case.
  AddMeals(this.repository);

  ///Executes the logic for adding a meal to the repository.
  Future<void> call(Meal meal){
    return repository.addMeal(meal);
  }
}
