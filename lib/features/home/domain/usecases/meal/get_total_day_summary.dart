import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';

///use case for getting product list by name
class GetTotalDaySummary{
  final ProductRepository repository;

  ///Constructor
  GetTotalDaySummary(this.repository);

  ///Executes the logic for getting product list from the api.
  Future<Map<String, double>> call(String dateKey){
    return repository.getTotalDaySummary(dateKey);
  }
}