import 'package:flutter/material.dart';

import '../../theme.dart';

class SportModel{
  int id;
  String name;
  int calories;
  String iconName;
  Color colorBlock;

  SportModel({
    required this.id,
    required this.name,
    required this.calories,
    required this.iconName,
    required this.colorBlock,
  });
}

List<SportModel> activities = [
  SportModel(
    id: 1,
      name: 'Ходьба',
      calories: 243,
      iconName: 'run',
      colorBlock: lightPurple
  ),
];