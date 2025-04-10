import 'dart:ui';

import 'package:calorify/core/theme.dart';
import 'package:calorify/features/home/domain/entities/sport.dart';

/// A model class that represents a sport, extending from the `Sport` entity
class SportModel extends Sport{
  final Color colorBlock;

  ///Constructor
  SportModel({
    required super.id,
    required super.name,
    required super.calories,
    required super.iconName,
    required this.colorBlock,
  });

  ///Converter from Entity to Model
  factory SportModel.fromEntity(Sport entity) {
    return SportModel(
      id: entity.id,
      name: entity.name,
      calories: entity.calories,
      iconName: entity.iconName,
      colorBlock: lightPurple,
    );
  }
}
