import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/domain/repositories/created_products_repository.dart';

class GetCreatedProductsFromHive{
  final CreatedProductsRepository _repository;

  GetCreatedProductsFromHive(this._repository);

  Future<List<MyProduct>> call(){
    return _repository.getCreatedProductsFromBoxCreated();
  }
}
