import 'package:flutter/material.dart';

import '../theme.dart';

class SportModel{
  String name;
  int calories;
  String iconName;
  Color colorBlock;

  SportModel({
    required this.name,
    required this.calories,
    required this.iconName,
    required this.colorBlock,
  });
}

List<SportModel> activities = [
  SportModel(
      name: 'Ходьба',
      calories: 243,
      iconName: 'run',
      colorBlock: lightPurple
  ),
];