
import 'package:calorify/core/entities/my_user.dart';
import 'package:calorify/features/food_page/domain/entity/own_product.dart';

abstract class CreatedProductsRepository {
  Future<void> registerUserToFoodFacts(String password);
  Future<void> saveOwnProduct(OwnProduct product);
}