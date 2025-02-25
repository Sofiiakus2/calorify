import 'package:flutter/material.dart';

import '../theme.dart';

class EatingModel{
  String meal;
  int calories;
  String iconName;
  Color colorBlock;
  bool isTodayOnly;

  EatingModel({
    required this.meal,
    required this.calories,
    required this.iconName,
    required this.colorBlock,
    required this.isTodayOnly,
  });
}

List<EatingModel> meals = [
  EatingModel(
      meal: 'Сніданок',
      calories: 243,
      iconName: 'pancakes',
      colorBlock: lightPurple,
      isTodayOnly: false,
  ),
  EatingModel(
      meal: 'Обід',
      calories: 335,
      iconName: 'salad',
      colorBlock: lightSalad,
    isTodayOnly: false,
  ),
  EatingModel(
      meal: 'Вечеря',
      calories: 0,
      iconName: 'soup',
      colorBlock: lightBlue,
    isTodayOnly: false,
  ),
  EatingModel(
      meal: 'Перекус',
      calories: 0,
      iconName: 'pretzel',
      colorBlock: lightPink,
    isTodayOnly: false,
  ),

];