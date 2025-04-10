import 'package:bloc/bloc.dart';

abstract class CaloriesState{
  const CaloriesState();
}

class CaloriesInitial extends CaloriesState{

}

class UpdateCaloriesState extends CaloriesState{
  final double calories;
  final double fats;
  final double carbohydrates;
  final double proteins;

  UpdateCaloriesState({
    required this.calories,
    required this.fats,
    required this.carbohydrates,
    required this.proteins,
  });
}