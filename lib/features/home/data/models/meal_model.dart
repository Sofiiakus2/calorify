
import 'package:calorify/core/theme.dart';
import 'package:calorify/features/home/domain/entities/meal.dart';
import 'package:flutter/material.dart';

/// A model class that represents a meal, extending from the `Meal` entity
class MealModel extends Meal{
  final Color colorBlock;

  /// Constructor
  MealModel({
    required super.meal,
    required super.calories,
    required super.iconName,
    required this.colorBlock,
    required super.isTodayOnly,
});

  ///Converter from Entity to Model
  factory MealModel.fromEntity(Meal entity) {
    return MealModel(
      meal: entity.meal,
      calories: entity.calories,
      iconName: entity.iconName,
      colorBlock: _getColor(entity.iconName),
      isTodayOnly: entity.isTodayOnly,
    );
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
}