import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/core/mappers/product_mapper.dart';
import 'package:calorify/features/food_page/data/datasources/remote/product_remote_data_source.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

///remove data source implementation
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<MyProduct> getProductByBarcode(String barcode) async {
    final config = ProductQueryConfiguration(
      barcode,
      language: OpenFoodFactsLanguage.GERMAN,
      fields: [ProductField.ALL],
      version: ProductQueryVersion.v3,
    );

    final result = await OpenFoodAPIClient.getProductV3(config);

    if (result.status == ProductResultV3.statusSuccess) {
      return ProductMapper.fromApiProduct(result.product!);
    } else {
      throw Exception('Продукт не знайдено: $barcode');
    }
  }

  @override
  Future<List<MyProduct>> getProductsByName(String name) async {

    final result = await OpenFoodAPIClient.searchProducts(
      null,
      ProductSearchQueryConfiguration(
        parametersList: [SearchTerms(terms: [name])],
        language: OpenFoodFactsLanguage.ENGLISH,
        fields: [ProductField.ALL],
        version: ProductQueryVersion.v3,
      ),
    );
    if (result.products != null && result.products!.isNotEmpty) {
      return result.products!.map(ProductMapper.fromApiProduct).toList();
    } else {
      throw Exception('Продукти з ім\'ям "$name" не знайдено.');
    }
  }
}
