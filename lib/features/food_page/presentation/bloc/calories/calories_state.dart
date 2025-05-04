import 'package:calorify/core/entities/my_product.dart';
import 'package:equatable/equatable.dart';

/// States
abstract class CaloriesState extends Equatable {

  @override
  List<Object?> get props => [];

  ///Constructor
  const CaloriesState();
}

///Initial State
class CaloriesInitial extends CaloriesState {
  final double calories;
  final double fats;
  final double carbohydrates;
  final double proteins;

  ///constructor
  const CaloriesInitial({
    required this.calories,
    required this.fats,
    required this.carbohydrates,
    required this.proteins,
  });

  factory CaloriesInitial.fromProduct(MyProduct product) {

    return CaloriesInitial(
      calories: product.energyKcal_100g ,
      fats: product.fat_100g ,
      carbohydrates: product.carbohydrates_100g,
      proteins: product.protein_100g ,
    );
  }
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
