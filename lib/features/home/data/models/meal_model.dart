
import 'package:calorify/core/theme.dart';
import 'package:calorify/features/home/data/models/product_for_meal_model.dart';
import 'package:calorify/features/home/domain/entities/meal.dart';
import 'package:flutter/material.dart';

/// A model class that represents a meal, extending from the `Meal` entity
class MealModel extends Meal{
  final Color colorBlock;
  final DateTime date;

  /// Constructor
  MealModel({
    required this.date,
    required super.meal,
    required super.calories,
    required super.iconName,
    required this.colorBlock,
    required super.isTodayOnly,
    required super.products,
});

  ///Converter from Entity to Model
  factory MealModel.fromEntity(Meal entity) {
    return MealModel(
      meal: entity.meal,
      calories: entity.calories,
      iconName: entity.iconName,
      colorBlock: _getColor(entity.iconName),
      isTodayOnly: entity.isTodayOnly,
      products: entity.products.toList(),
      date: DateTime.now(),
    );
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      date: DateTime.parse(map['date'] as String),
      meal: map['meal'] as MealType,
      calories: map['calories'] as int ?? 0,
      iconName: map['iconName'] as String ?? 'avocado',
      colorBlock: _getColor(map['iconName'] as String),
      isTodayOnly: map['isTodayOnly'] as bool,
      products: (map['products'] as List<dynamic>)
          .map((e) => ProductForMealModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'meal': meal.name,
      'date': date.toIso8601String(),
      'calories': calories,
      'iconName': iconName,
      'isTodayOnly': isTodayOnly,
      'products': products.map((e) => (e as ProductForMealModel).toMap()).toList(),
    };
  }

  static Color _getColor(String icon) {
    switch (icon) {
      case 'pancakes':
        return lightPurple;
      case 'salad':
        return lightSalad;
      case 'soup':
        return lightBlue;
      case 'pretzel':
        return lightPink;
      default:
        return Colors.grey;
    }
  }

  static String getMealTypePath(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snack:
        return 'Snack';
      case MealType.custom:
        return 'Custom';
    }
  }
}
