
import 'package:calorify/features/food_page/domain/repositories/created_products_repository.dart';

class RegisterUserToFoodFacts{
  final CreatedProductsRepository _createdProductsRepository;

  RegisterUserToFoodFacts(this._createdProductsRepository);

  Future<void> registerUserToFoodFacts(String password){
    return _createdProductsRepository.registerUserToFoodFacts(password);
  }
}