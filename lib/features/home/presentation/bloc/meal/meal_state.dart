import 'package:bloc/bloc.dart';
import 'package:calorify/features/home/domain/entities/meal.dart';
import 'package:calorify/features/home/domain/usecases/meal/add_meals.dart';
import 'package:calorify/features/home/domain/usecases/meal/get_meals.dart';

///State for meals
class MealState {
  final List<Meal> meals;

  ///Constructor
  MealState({required this.meals});
}

///Cubit for meal updates
class MealCubit extends Cubit<MealState> {
  final GetMeals getMeals;
  final AddMeals addMeal;

  ///Constructor
  MealCubit({required this.getMeals, required this.addMeal})
      : super(MealState(meals:[]));

  ///method for loading meal State
  Future<void> loadMeals() async{
    final meals = await getMeals();
    emit(MealState(meals: meals));
  }

  ///method for adding new meal and update the state
  Future<void> add(Meal meal) async {
    await addMeal(meal);
    await loadMeals();
  }
}
