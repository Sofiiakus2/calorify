// meal_summary_cubit.dart
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:calorify/features/home/domain/usecases/meal/get_meal_summary.dart';
import 'package:calorify/features/home/presentation/bloc/meal/meal_summary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealSummaryCubit extends Cubit<MealSummaryState> {
  final GetMealSummary getMealSummary;
  final Map<String, MealModel> _cachedMeals = {};

  MealSummaryCubit({required this.getMealSummary}) : super(MealSummaryInitial());

  Future<void> loadMeal(String mealType, String dateKey) async {
    final key = '$mealType|$dateKey';

    try {
      final meal = await getMealSummary(mealType, dateKey);
      if (meal != null) {
        if (!_cachedMeals.containsKey(key) || !_mealsEqual(_cachedMeals[key]!, meal)) {
          _cachedMeals[key] = meal;
          emit(MealSummaryLoaded({mealType: meal}));
        }
      } else {
        emit(MealSummaryEmpty());
      }
    } catch (e) {
      emit(MealSummaryError(e.toString()));
    }
  }

  bool _mealsEqual(MealModel a, MealModel b) {
    return a.calories == b.calories &&
        a.proteins == b.proteins &&
        a.fats == b.fats &&
        a.carbs == b.carbs;
  }
}
