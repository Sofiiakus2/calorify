import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';

///use case for saving product to hive history
class RecountLeftCalories{
  final ProductRepository repository;

  ///Constructor
  RecountLeftCalories(this.repository);

  ///Executes the logic for getting product list from the api.
  Future<double> call(MyProduct product){
    return repository.recountLeftCalories(product);
  }
}
