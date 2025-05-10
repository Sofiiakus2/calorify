import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';
import 'package:calorify/features/home/data/models/product_for_meal_model.dart';

///use case for getting product list by name
class GetProductsForMeal{
  final ProductRepository repository;

  ///Constructor
  GetProductsForMeal(this.repository);

  ///Executes the logic for getting product list from the api.
  Future<List<ProductForMealModel>> call(String mealType, String dateKey){
    return repository.getProductsForMeal(mealType, dateKey);
  }
}