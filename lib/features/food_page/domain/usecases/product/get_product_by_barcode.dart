import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';

///use case for getting product by barcode
class GetProductByBarcode{
  final ProductRepository repository;

  ///Constructor
  GetProductByBarcode(this.repository);

  ///Executes the logic for getting product from the api.
  Future<MyProduct> call(String barcode){
    return repository.getProductByBarcode(barcode);
  }
}