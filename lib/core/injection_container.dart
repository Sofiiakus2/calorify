
import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/core/provider/user_provide.dart';
import 'package:calorify/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:calorify/features/auth/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:calorify/features/auth/data/repositories/user_repository_impl.dart';
import 'package:calorify/features/auth/domain/repositories/user_repository.dart';
import 'package:calorify/features/auth/domain/usecases/enter_user.dart';
import 'package:calorify/features/auth/domain/usecases/get_user_by_id.dart';
import 'package:calorify/features/auth/domain/usecases/register_user.dart';
import 'package:calorify/features/food_page/data/datasources/local/product_local_data_source.dart';
import 'package:calorify/features/food_page/data/datasources/local/product_local_data_source_impl.dart';
import 'package:calorify/features/food_page/data/datasources/remote/product_remote_data_source_impl.dart';
import 'package:calorify/features/food_page/data/datasources/remote/product_remote_data_source.dart';
import 'package:calorify/features/food_page/data/repositories/product_repository_impl.dart';
import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';
import 'package:calorify/features/food_page/domain/usecases/product/get_meal_summary.dart';
import 'package:calorify/features/food_page/domain/usecases/product/get_product_by_barcode.dart';
import 'package:calorify/features/food_page/domain/usecases/product/get_products_by_name.dart';
import 'package:calorify/features/food_page/domain/usecases/product/get_products_from_history.dart';
import 'package:calorify/features/food_page/domain/usecases/product/get_total_day_summary.dart';
import 'package:calorify/features/food_page/domain/usecases/product/recount_left_calories.dart';
import 'package:calorify/features/food_page/domain/usecases/product/save_product_to_db.dart';
import 'package:calorify/features/food_page/domain/usecases/product/save_product_to_history.dart';
import 'package:calorify/features/food_page/presentation/bloc/calories/calories_bloc.dart';
import 'package:calorify/features/food_page/presentation/bloc/food/food_block.dart';
import 'package:calorify/features/home/data/repository/meal_repository_impl.dart';
import 'package:calorify/features/home/data/repository/sport_repository_impl.dart';
import 'package:calorify/features/home/domain/repositories/meal_repository.dart';
import 'package:calorify/features/home/domain/repositories/sport_repository.dart';
import 'package:calorify/features/home/domain/usecases/meal/add_meals.dart';
import 'package:calorify/features/home/domain/usecases/meal/get_meals.dart';
import 'package:calorify/features/home/domain/usecases/sport/add_sport.dart';
import 'package:calorify/features/home/domain/usecases/sport/delete_sport.dart';
import 'package:calorify/features/home/domain/usecases/sport/get_sport.dart';
import 'package:calorify/features/home/presentation/bloc/meal/meal_summary_cubit.dart';
import 'package:get_it/get_it.dart';

/// A service locator instance for managing dependency injection using GetIt.
final sl = GetIt.instance;

/// Initializes the application's dependencies.
Future<void> init() async{
  sl.registerLazySingleton<MealRepository>(MealRepositoryImpl.new);
  sl.registerLazySingleton<SportRepository>(SportRepositoryImpl.new);
  sl.registerLazySingleton<ProductLocalDataSource>(ProductLocalDataSourceImpl.new);
  sl.registerLazySingleton<ProductRemoteDataSource>(ProductRemoteDataSourceImpl.new);
  sl.registerLazySingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl.new);

  sl.registerLazySingleton<UserProvider>(UserProvider.new);

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      authRemoteDataSource: sl<AuthRemoteDataSource>(),),);

  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
    remoteDataSource: sl<ProductRemoteDataSource>(),
    localDataSource: sl<ProductLocalDataSource>(),
  ),);

  sl.registerLazySingleton(() => GetMeals(sl()));
  sl.registerLazySingleton(() =>AddMeals(sl()));

  sl.registerLazySingleton(() => GetSport(sl()));
  sl.registerLazySingleton(() => AddSport(sl()));
  sl.registerLazySingleton(() => DeleteSport(sl()));

  sl.registerLazySingleton(() => GetProductsFromHistory(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetProductsByName(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetProductByBarcode(sl<ProductRepository>()));
  sl.registerLazySingleton(() => SaveProductToHistory(sl<ProductRepository>()));
  sl.registerLazySingleton(() => SaveProductToDb(sl<ProductRepository>()));
  sl.registerLazySingleton(() => RecountLeftCalories(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetMealSummary(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetTotalDaySummary(sl<ProductRepository>()));


  sl.registerLazySingleton(() => RegisterUser(sl<UserRepository>()));
  sl.registerLazySingleton(() => EnterUser(sl<UserRepository>()));
  sl.registerLazySingleton(() => GetUserById(sl<UserRepository>()));

  sl.registerFactory(() => FoodBlock(
    getProductsByName: sl(),
    getProductByBarcode: sl(),
    saveProductToHistory: sl(),
    getProductsFromHistory: sl(),
  ),);

  sl.registerFactoryParam<CaloriesBloc, MyProduct, void>((product, _) => CaloriesBloc(product));
  sl.registerFactory(() => MealSummaryCubit(getMealSummary: sl()));


}
