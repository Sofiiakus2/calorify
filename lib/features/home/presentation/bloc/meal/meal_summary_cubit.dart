// meal_summary_cubit.dart
import 'package:calorify/features/home/domain/usecases/meal/get_meal_summary.dart';
import 'package:calorify/features/home/presentation/bloc/meal/meal_summary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealSummaryCubit extends Cubit<MealSummaryState> {
  final GetMealSummary getMealSummary;


  MealSummaryCubit({
    required this.getMealSummary,
  }) : super(MealSummaryInitial());

  Future<void> loadMeal(String mealType, String dateKey) async {
    emit(MealSummaryLoading());
    try {
      final meal = await getMealSummary(mealType, dateKey);
      print('================');
      print(meal);
      if (meal != null) {
        emit(MealSummaryLoaded({mealType: meal}));
      } else {
        emit(MealSummaryEmpty());
      }
    } catch (e) {
      emit(MealSummaryError(e.toString()));
    }
  }

  Future<void> refreshMeal(String mealType, String dateKey) async {
    // optional separate logic
  }
}