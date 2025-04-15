import 'package:equatable/equatable.dart';

/// States
abstract class CaloriesState extends Equatable {

  @override
  List<Object?> get props => [];

  ///Constructor
  const CaloriesState();
}

///Initial State
class CaloriesInitial extends CaloriesState{
  ///Constructor
  const CaloriesInitial();
}

///Update State
class UpdateCaloriesState extends CaloriesState{
  final double calories;
  final double fats;
  final double carbohydrates;
  final double proteins;

  @override
  List<Object?> get props => [calories, fats, carbohydrates, proteins];

  ///Constructor
  const UpdateCaloriesState({
    required this.calories,
    required this.fats,
    required this.carbohydrates,
    required this.proteins,
  });


}
