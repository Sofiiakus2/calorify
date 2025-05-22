import 'package:calorify/core/entities/my_product.dart';

class AnalyzedMeal {
  final List<MyProduct> products;
  final Totals totals;

  AnalyzedMeal({required this.products, required this.totals});
}

class Totals {
  final double totalCalories;
  final double totalProteins;
  final double totalFats;
  final double totalCarbohydrates;

  Totals({
    required this.totalCalories,
    required this.totalProteins,
    required this.totalFats,
    required this.totalCarbohydrates,
  });
}
