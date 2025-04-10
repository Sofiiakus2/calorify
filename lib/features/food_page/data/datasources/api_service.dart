import 'dart:async';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../../../../data/models/product_model.dart';

class OpenFoodFactsApiClass {
  OpenFoodFactsApiClass() {
    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'calorify');
  }

  ProductModel fromProductToModel(Product product) {
    var nutriments = product.nutriments;

    return ProductModel(
      name: product.productName ?? 'Невідомий продукт',
      barcode: product.barcode ?? 'Немає штрихкоду',
      brand: product.brands ?? '',
      energyKcal_100g: nutriments?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ?? 0.0,
      energyKj_100g: nutriments?.getValue(Nutrient.energyKJ, PerSize.oneHundredGrams) ?? 0.0,
      sugar_100g: nutriments?.getValue(Nutrient.sugars, PerSize.oneHundredGrams) ?? 0.0,
      protein_100g: nutriments?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? 0.0,
      fat_100g: nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? 0.0,
      carbohydrates_100g: nutriments?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ?? 0.0,

      energyKcal_saved: nutriments?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ?? 0.0,
      energyKj_saved: nutriments?.getValue(Nutrient.energyKJ, PerSize.oneHundredGrams) ?? 0.0,
      sugar_saved: nutriments?.getValue(Nutrient.sugars, PerSize.oneHundredGrams) ?? 0.0,
      protein_saved: nutriments?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? 0.0,
      fat_saved: nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? 0.0,
      carbohydrates_saved: nutriments?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ?? 0.0,
    );
  }

  Stream<ProductModel> getProductByBarcode(String barcode) async* {
    final ProductQueryConfiguration configuration = ProductQueryConfiguration(
      barcode,
      language: OpenFoodFactsLanguage.GERMAN,
      fields: [ProductField.ALL],
      version: ProductQueryVersion.v3,
    );

    final ProductResultV3 result = await OpenFoodAPIClient.getProductV3(configuration);

    if (result.status == ProductResultV3.statusSuccess) {
      yield fromProductToModel(result.product!);
    } else {
      throw Exception('Продукт не знайдено, будь ласка, введіть дані для $barcode');
    }
  }

  Stream<List<ProductModel>> searchProductsByName(String name) async* {
    final SearchResult result = await OpenFoodAPIClient.searchProducts(
      User(userId: 'your_unique_id', comment: 'Flutter app using OpenFoodFacts API', password: ''),
      ProductSearchQueryConfiguration(
        parametersList: [SearchTerms(terms: [name])],
        language: OpenFoodFactsLanguage.ENGLISH,
        fields: [ProductField.ALL],
        version: ProductQueryVersion.v3,
      ),
    );

    if (result.products != null && result.products!.isNotEmpty) {
      yield result.products!.map((product) => fromProductToModel(product)).toList();
    } else {
      throw Exception('Продукти за назвою "$name" не знайдено.');
    }
  }
}
