import 'package:flutter/material.dart';

import '../../../../core/theme.dart';


class Meal{
  String meal;
  int calories;
  String iconName;
  bool isTodayOnly;

  Meal({
    required this.meal,
    required this.calories,
    required this.iconName,
    required this.isTodayOnly,
  });
}

// List<Meal> meals = [
//   Meal(
//       meal: 'Сніданок',
//       calories: 243,
//       iconName: 'pancakes',
//       colorBlock: lightPurple,
//       isTodayOnly: false,
//   ),
//   Meal(
//       meal: 'Обід',
//       calories: 335,
//       iconName: 'salad',
//       colorBlock: lightSalad,
//     isTodayOnly: false,
//   ),
//   Meal(
//       meal: 'Вечеря',
//       calories: 0,
//       iconName: 'soup',
//       colorBlock: lightBlue,
//     isTodayOnly: false,
//   ),
//   Meal(
//       meal: 'Перекус',
//       calories: 0,
//       iconName: 'pretzel',
//       colorBlock: lightPink,
//     isTodayOnly: false,
//   ),
//
// ];