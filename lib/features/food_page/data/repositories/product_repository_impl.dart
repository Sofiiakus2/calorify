
import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/data/datasources/local/product_local_data_source.dart';
import 'package:calorify/features/food_page/data/datasources/remote/product_remote_data_source.dart';
import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';

///Product repository implementation
class ProductRepositoryImpl extends ProductRepository{
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ///Constructor
  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
});

  @override
  Future<MyProduct> getProductByBarcode(String barcode) async {
    return remoteDataSource.getProductByBarcode(barcode);
  }

  @override
  Future<List<MyProduct>> getProductsByName(String name) async {
    return remoteDataSource.getProductsByName(name);
  }


  @override
  Future<List<MyProduct>> getProductsFromHistory() async{
    return localDataSource.getProductsFromHistory();
  }

  @override
  Future<void> saveProductToHistory(MyProduct product) async{
    return localDataSource.saveProductToHistory(product);
  }

}
