import 'package:calorify/core/entities/my_product.dart';

///local data source HIVE
abstract class ProductLocalDataSource {
  ///save product to hive history
  Future<void> saveProductToHistory(MyProduct product);

  ///get product list from hive
  Future<List<MyProduct>> getProductsFromHistory();

  Future<List<MyProduct>> getCreatedProductsFromBoxCreated();
}
