
import 'package:calorify/core/entities/my_product.dart';

///remote data source
abstract class ProductRemoteDataSource {
  ///method for getting one product by barcode
  Future<MyProduct> getProductByBarcode(String barcode);

  ///method for getting product list bu name
  Future<List<MyProduct>> getProductsByName(String name);
}
