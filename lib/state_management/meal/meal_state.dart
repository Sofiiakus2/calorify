import 'package:bloc/bloc.dart';
import 'package:calorify/models/eating_model.dart';

class MealState {
  final List<EatingModel> meals;

  MealState({required this.meals});
}

class MealCubit extends Cubit<MealState> {
  MealCubit() : super(MealState(meals:meals));

  void addMeal(EatingModel meal) {
    final updatedMeals = List<EatingModel>.from(state.meals)..add(meal);
    emit(MealState(meals: updatedMeals));
  }
}
