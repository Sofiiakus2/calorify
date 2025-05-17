
import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/domain/entity/own_product.dart';

abstract class CreatedProductsRepository {
  Future<void> registerUserToFoodFacts(String password);
  Future<void> saveOwnProduct(OwnProduct product);
  Future<List<MyProduct>> getCreatedProductsFromBoxCreated();

}
