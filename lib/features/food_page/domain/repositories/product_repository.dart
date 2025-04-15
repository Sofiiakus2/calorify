
import 'package:calorify/core/entities/my_product.dart';

///Product Repository
abstract class ProductRepository{
  ///method for getting product list by name
  Future<List<MyProduct>> getProductsByName(String name);

  ///method for getting product list by barcode
  Future<MyProduct> getProductByBarcode(String barcode);

  ///method for getting product history
  Future<List<MyProduct>> getProductsFromHistory();

  ///method for saving product to hive history of searching products
  Future<void> saveProductToHistory(MyProduct product);


}
