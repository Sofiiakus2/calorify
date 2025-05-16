import 'package:openfoodfacts/openfoodfacts.dart' as open;


class OwnProduct {
  /// Обов'язкові поля
  final String code;
  final String productName;
  final String brands;
  final String quantity;
  final String ingredientsText;
  final String nutritionDataPer;
  final String energyKcal;
  final String fat;
  final String proteins;
  final String carbohydrates;

  /// Необов'язкові поля (додаються пізніше)
  final String lang;
  final String? userId;
  final String? password;
  final String comment;

  OwnProduct({
    required this.code,
    required this.productName,
    required this.brands,
    required this.quantity,
    required this.ingredientsText,
    required this.nutritionDataPer,
    required this.energyKcal,
    required this.fat,
    required this.proteins,
    required this.carbohydrates,
    this.lang = 'uk',
    this.userId,
    this.password,
    this.comment = 'Додано через мобільний застосунок',
  });

  Map<String, String> toJson() {
    return {
      'code': code,
      'product_name': productName,
      'brands': brands,
      'quantity': quantity,
      'ingredients_text': ingredientsText,
      'nutrition_data_per': nutritionDataPer,
      'nutriment_energy': energyKcal,
      'nutriment_fat': fat,
      'nutriment_proteins': proteins,
      'nutriment_carbohydrates': carbohydrates,
      'lang': lang,
      if (userId != null) 'user_id': userId!,
      if (password != null) 'password': password!,
      'comment': comment,
    };
  }

}

extension OwnProductMapper on OwnProduct {
  open.Product toOpenFoodFactsProduct() {
    return open.Product(
      barcode: code,
      productName: productName,
      brands: brands,
      quantity: quantity,
      ingredientsText: ingredientsText,
      lang: open.OpenFoodFactsLanguage.UKRAINIAN,
      nutriments: open.Nutriments.fromJson({
        'energy-kcal_100g': energyKcal,
        'fat_100g': fat,
        'proteins_100g': proteins,
        'carbohydrates_100g': carbohydrates,
      }),
      nutrimentDataPer: '100g',
    );
  }
}

