import 'package:calorify/features/food_page/domain/entity/own_product.dart';
import 'package:calorify/features/food_page/domain/repositories/created_products_repository.dart';

class SaveProductToFoodFact{
  final CreatedProductsRepository _repository;

  SaveProductToFoodFact(this._repository);

  Future<void> call(OwnProduct product){
    return _repository.saveOwnProduct(product);
  }
}