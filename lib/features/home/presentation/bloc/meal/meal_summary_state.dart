import 'package:calorify/features/home/data/models/meal_model.dart';

abstract class MealSummaryState {}

class MealSummaryInitial extends MealSummaryState {}
class MealSummaryLoading extends MealSummaryState {}
class MealSummaryLoaded extends MealSummaryState {
  final Map<String, MealModel> meals;

  MealSummaryLoaded(this.meals);
}

class MealSummaryEmpty extends MealSummaryState {}
class MealSummaryError extends MealSummaryState {
  final String message;
  MealSummaryError(this.message);
}
