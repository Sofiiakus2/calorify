import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';

///use case for getting product list from hive history
class GetProductsFromHistory{
  final ProductRepository repository;

  ///Constructor
  GetProductsFromHistory(this.repository);

  ///Executes the logic for getting product list from the history.
  Future<List<MyProduct>> call() async{
    return repository.getProductsFromHistory();
  }
}
