import 'package:bloc/bloc.dart';
import 'package:calorify/features/home/domain/usecases/eating/get_meals.dart';

import '../../../domain/entities/meal.dart';
import '../../../domain/usecases/eating/add_meals.dart';

class MealState {
  final List<Meal> meals;

  MealState({required this.meals});
}

class MealCubit extends Cubit<MealState> {
  final GetMeals getMeals;
  final AddMeals addMeal;

  MealCubit({required this.getMeals, required this.addMeal})
      : super(MealState(meals:[]));

  Future<void> loadMeals() async{
    final meals = await getMeals();
    emit(MealState(meals: meals));
  }

  Future<void> add(Meal meal) async {
    await addMeal(meal);
    await loadMeals();
  }
}
