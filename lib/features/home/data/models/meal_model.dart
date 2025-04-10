import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../domain/entities/meal.dart';

class MealModel extends Meal{
  final Color colorBlock;

  MealModel({
    required super.meal,
    required super.calories,
    required super.iconName,
    required this.colorBlock,
    required super.isTodayOnly,
});

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