
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:calorify/features/home/data/models/product_for_meal_model.dart';

///daily meal entity
class DailyMeal{
  final DateTime date;
  final MealModel mealName;
  final List<ProductForMealModel> meals;

  ///Constructor
  DailyMeal({
    required this.date,
    required this.mealName,
    required this.meals,
});

  ///from map to model
  factory DailyMeal.fromMap(Map<String, dynamic> map) {
    return DailyMeal(
      date: DateTime.parse(map['date'] as String),
      mealName: MealModel.fromMap(map['meal'] as Map<String, dynamic>),
      meals: (map['products'] as List<dynamic>)
          .map((e) => ProductForMealModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }


  ///from model to map
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'meal': mealName.toMap(),
      'products': meals.map((m) => m.toMap()).toList(),
    };
  }
}
