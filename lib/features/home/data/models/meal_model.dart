
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
    required super.proteins,
    required super.fats,
    required super.carbs,
});

  ///Converter from Entity to Model
  factory MealModel.fromEntity(Meal entity) {
    return MealModel(
      meal: entity.meal,
      calories: entity.calories,
      proteins: entity.proteins,
      fats: entity.fats,
      carbs: entity.carbs,
      iconName: entity.iconName,
      colorBlock: getColor(entity.iconName),
      isTodayOnly: entity.isTodayOnly,
      products: entity.products.toList(),
      date: DateTime.now(),
    );
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      date: DateTime.parse(map['date'] as String),
      meal: MealType.values.firstWhere((e) => e.name == map['meal']),
      calories: map['calories'] as double ,
      proteins: map['proteins'] as double,
      fats: map['fats'] as double,
      carbs: map['carbohydrates'] as double,
      iconName: map['iconName'] as String ,
      colorBlock: getColor(map['iconName'] as String),
      isTodayOnly: map['isTodayOnly'] as bool,
      products: (map['products'] is List)
          ? (map['products'] as List<dynamic>)
          .map((e) => ProductForMealModel.fromMap(e as Map<String, dynamic>))
          .toList()
          : [],


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

  static Color getColor(String icon) {
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

  static String getIcon(String name) {
    switch (name) {
      case 'breakfast':
        return 'pancakes';
      case 'lunch':
        return 'salad';
      case 'dinner':
        return 'soup';
      case 'snack':
        return 'pretzel';
      default:
        return 'broccoli';
    }
  }

  static String getMealTypePath(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return 'breakfast';
      case MealType.lunch:
        return 'lunch';
      case MealType.dinner:
        return 'dinner';
      case MealType.snack:
        return 'snack';
      case MealType.custom:
        return 'custom';
    }
  }

  static String getMealNameUkrainian(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return 'Сніданок';
      case MealType.lunch:
        return 'Обід';
      case MealType.dinner:
        return 'Вечеря';
      case MealType.snack:
        return 'Перекус';
      case MealType.custom:
        return 'Інше';
      default:
        return 'Невідомо';
    }
  }

}
