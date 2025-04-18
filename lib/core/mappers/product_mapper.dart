import 'package:calorify/features/food_page/data/model/product_model.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

///Mapper for converting from api product to product model
class ProductMapper {
  static ProductModel fromApiProduct(Product product) {
    final nutriments = product.nutriments;

    return ProductModel(
      name: product.productName ?? 'Невідомий продукт',
      barcode: product.barcode ?? 'Немає штрихкоду',
    //  brand: product.brands ?? '',
      energyKcal_100g: nutriments?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ?? 0.0,
    //  energyKj_100g: nutriments?.getValue(Nutrient.energyKJ, PerSize.oneHundredGrams) ?? 0.0,
    //  sugar_100g: nutriments?.getValue(Nutrient.sugars, PerSize.oneHundredGrams) ?? 0.0,
      protein_100g: nutriments?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? 0.0,
      fat_100g: nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? 0.0,
      carbohydrates_100g: nutriments?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ?? 0.0,
      // energyKcal_saved: nutriments?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams) ?? 0.0,
      // energyKj_saved: nutriments?.getValue(Nutrient.energyKJ, PerSize.oneHundredGrams) ?? 0.0,
      // sugar_saved: nutriments?.getValue(Nutrient.sugars, PerSize.oneHundredGrams) ?? 0.0,
      // protein_saved: nutriments?.getValue(Nutrient.proteins, PerSize.oneHundredGrams) ?? 0.0,
      // fat_saved: nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams) ?? 0.0,
      // carbohydrates_saved: nutriments?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) ?? 0.0,
    );
  }
}
