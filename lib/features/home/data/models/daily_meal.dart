import 'package:calorify/features/home/data/models/meal_model.dart';

///daily meal entity
class DailyMeal{
  final DateTime date;
  final List<MealModel> meals;

  ///Constructor
  DailyMeal({
    required this.date,
    required this.meals,
});

  factory DailyMeal.fromMap(Map<String, dynamic> map) {
    return DailyMeal(
      date: DateTime.parse(map['date'] as String),
      meals: (map['products'] as List<dynamic>)
          .map((e) => MealModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'meals': meals.map((m) => m.toMap()).toList(),
    };
  }
}
