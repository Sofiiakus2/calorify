
import 'package:calorify/features/home/data/repository/meal_repository_impl.dart';
import 'package:calorify/features/home/data/repository/sport_repository_impl.dart';
import 'package:calorify/features/home/domain/repositories/meal_repository.dart';
import 'package:calorify/features/home/domain/repositories/sport_repository.dart';
import 'package:calorify/features/home/domain/usecases/meal/add_meals.dart';
import 'package:calorify/features/home/domain/usecases/meal/get_meals.dart';
import 'package:calorify/features/home/domain/usecases/sport/add_sport.dart';
import 'package:calorify/features/home/domain/usecases/sport/delete_sport.dart';
import 'package:calorify/features/home/domain/usecases/sport/get_sport.dart';
import 'package:get_it/get_it.dart';

/// A service locator instance for managing dependency injection using GetIt.
final sl = GetIt.instance;

/// Initializes the application's dependencies.
Future<void> init() async{
  sl.registerLazySingleton<MealRepository>(MealRepositoryImpl.new);
  sl.registerLazySingleton<SportRepository>(SportRepositoryImpl.new);


  sl.registerLazySingleton(() => GetMeals(sl()));
  sl.registerLazySingleton(() =>AddMeals(sl()));

  sl.registerLazySingleton(() => GetSport(sl()));
  sl.registerLazySingleton(() => AddSport(sl()));
  sl.registerLazySingleton(() => DeleteSport(sl()));

}
