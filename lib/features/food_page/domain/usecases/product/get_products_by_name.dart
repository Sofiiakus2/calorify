import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';

///use case for getting product list by name
class GetProductsByName{
  final ProductRepository repository;

  ///Constructor
  GetProductsByName(this.repository);

  ///Executes the logic for getting product list from the api.
  Future<List<MyProduct>> call(String name){
    return repository.getProductsByName(name);
  }
}