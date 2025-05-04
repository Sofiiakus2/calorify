import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';

///use case for saving product to hive history
class SaveProductToDb{
  final ProductRepository repository;

  ///Constructor
  SaveProductToDb(this.repository);

  ///Executes the logic for getting product list from the api.
  Future<void> call(MyProduct product, MealModel meal){
    return repository.saveProductToDb(product, meal);
  }
}
