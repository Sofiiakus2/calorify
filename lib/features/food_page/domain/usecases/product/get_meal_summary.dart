import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';

///use case for getting product list by name
class GetMealSummary{
  final ProductRepository repository;

  ///Constructor
  GetMealSummary(this.repository);

  ///Executes the logic for getting product list from the api.
  Future<MealModel?> call(String mealType, String dateKey){
    return repository.getMealSummary(mealType, dateKey);
  }
}