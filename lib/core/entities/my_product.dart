import 'package:calorify/features/ai_functional/domain/entities/analyzed_meal.dart';
import 'package:hive/hive.dart';
import 'package:openfoodfacts/openfoodfacts.dart' as open;

///Product Entity
@HiveType(typeId: 0)
class MyProduct extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  String barcode;
  String? brand;
  @HiveField(2)
  double energyKcal_100g;
  double? energyKj_100g;
  @HiveField(3)
  double? sugar_100g;
  @HiveField(4)
  double protein_100g;
  @HiveField(5)
  double fat_100g;
  @HiveField(6)
  double carbohydrates_100g;

  double? energyKcal_saved;
  double? energyKj_saved;
  double? sugar_saved;
  double? protein_saved;
  double? fat_saved;
  double? carbohydrates_saved;
  String? weight;

  ///Constructor
  MyProduct({
    required this.name,
    required this.barcode,
    this.brand,
    required this.energyKcal_100g,
    this.energyKj_100g,
    this.sugar_100g,
    required this.protein_100g,
    required this.fat_100g,
    required this.carbohydrates_100g,
    this.energyKcal_saved,
    this.energyKj_saved,
    this.sugar_saved,
    this.protein_saved,
    this.fat_saved,
    this.carbohydrates_saved,
    this.weight,
  });

  ///Copy with method
  // ignore: number_of_parameters
  MyProduct copyWith({
    String? name,
    String? barcode,
    String? brand,
    double? energyKcal_100g,
    double? energyKj_100g,
    double? sugar_100g,
    double? protein_100g,
    double? fat_100g,
    double? carbohydrates_100g,
    String? weight,
  }) {
    return MyProduct(
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      brand: brand ?? this.brand,
      energyKcal_100g: energyKcal_100g ?? this.energyKcal_100g,
      energyKj_100g: energyKj_100g ?? this.energyKj_100g,
      sugar_100g: sugar_100g ?? this.sugar_100g,
      protein_100g: protein_100g ?? this.protein_100g,
      fat_100g: fat_100g ?? this.fat_100g,
      carbohydrates_100g: carbohydrates_100g ?? this.carbohydrates_100g,
      weight: weight ?? this.weight,
    );
  }

  static MyProduct fromTotals(Totals totals) {
    return MyProduct(
      name: 'own',
      barcode: '',
      energyKcal_100g: totals.totalCalories,
      protein_100g: totals.totalProteins,
      fat_100g: totals.totalFats,
      carbohydrates_100g: totals.totalCarbohydrates,
      energyKcal_saved: totals.totalCalories,
      protein_saved: totals.totalProteins,
      fat_saved: totals.totalFats,
      carbohydrates_saved: totals.totalCarbohydrates,
      sugar_100g: 0.0,
    );
  }


  static MyProduct mapOpenFoodProductToMyProduct(open.Product product) {
    final nutriments = product.nutriments;

    double getNutrient(open.Nutrient nutrient) {
      return nutriments?.getValue(nutrient, open.PerSize.oneHundredGrams) ?? 0.0;
    }

    return MyProduct(
      name: product.productName ?? 'Unknown',
      barcode: product.barcode ?? '',
      brand: product.brands ?? '',
      energyKcal_100g: getNutrient(open.Nutrient.energyKCal),
      energyKj_100g: getNutrient(open.Nutrient.energyKJ),
      sugar_100g: getNutrient(open.Nutrient.sugars),
      protein_100g: getNutrient(open.Nutrient.proteins),
      fat_100g: getNutrient(open.Nutrient.fat),
      carbohydrates_100g: getNutrient(open.Nutrient.carbohydrates),
    );
  }


}
