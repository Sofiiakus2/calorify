import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/core/injection_container.dart';
import 'package:calorify/core/theme.dart';
import 'package:calorify/features/food_page/data/model/product_model.dart';
import 'package:calorify/features/food_page/data/model/product_model_adapter.dart';
import 'package:calorify/features/bottom_navigation/presentation/pages/custom_bottom_navigation_view.dart';
import 'package:calorify/features/food_page/domain/usecases/product/get_products_from_history.dart';
import 'package:calorify/features/food_page/presentation/bloc/food/food_block.dart';
import 'package:calorify/features/food_page/presentation/bloc/food/food_event.dart';
import 'package:calorify/features/home/domain/usecases/meal/add_meals.dart';
import 'package:calorify/features/home/domain/usecases/meal/get_meals.dart';
import 'package:calorify/features/home/domain/usecases/sport/add_sport.dart';
import 'package:calorify/features/home/domain/usecases/sport/delete_sport.dart';
import 'package:calorify/features/home/domain/usecases/sport/get_sport.dart';
import 'package:calorify/features/home/presentation/bloc/meal/meal_state.dart';
import 'package:calorify/features/home/presentation/bloc/sport/sport_state.dart';
import 'package:calorify/features/home/presentation/bloc/water/water_state.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/food/grid_food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:openfoodfacts/openfoodfacts.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<MyProduct>('historyBox');
  OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'calorify');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MealCubit>(
            create: (context) => MealCubit(
              getMeals: sl<GetMeals>(),
              addMeal: sl<AddMeals>(),
            )..loadMeals(),
          child: const GridFood(),
        ),
        BlocProvider<SportCubit>(
            create: (context) => SportCubit(
              getSport: sl<GetSport>(),
              addSport: sl<AddSport>(),
              deleteSport: sl<DeleteSport>(),
            )..loadSport(),
        ),
        BlocProvider<WaterCubit>(
            create: (context) => WaterCubit(),
        ),
        BlocProvider<FoodBlock>(
          create: (context) => sl<FoodBlock>()..add(LoadHistory()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const CustomBottomNavigationView(),
      ),
    );
  }
}
