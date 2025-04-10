
import 'package:calorify/features/home/data/repository/meal_repository_impl.dart';
import 'package:calorify/features/home/domain/repositories/meal_repository.dart';
import 'package:calorify/features/home/domain/usecases/eating/add_meals.dart';
import 'package:calorify/features/home/domain/usecases/eating/get_meals.dart';
import 'package:get_it/get_it.dart';

/// A service locator instance for managing dependency injection using GetIt.
final sl = GetIt.instance;

/// Initializes the application's dependencies.
Future<void> init() async{
  sl.registerLazySingleton<MealRepository>(MealRepositoryImpl.new);

  sl.registerLazySingleton(() => GetMeals(sl()));
  sl.registerLazySingleton(() =>AddMeals(sl()));
}
