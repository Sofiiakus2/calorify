import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';

///use case for saving product to hive history
class SaveProductToHistory{
  final ProductRepository repository;

  ///Constructor
  SaveProductToHistory(this.repository);

  ///Executes the logic for getting product list from the api.
  Future<void> call(MyProduct product){
    return repository.saveProductToHistory(product);
  }
}
