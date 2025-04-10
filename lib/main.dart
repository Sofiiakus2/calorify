import 'package:calorify/features/home/domain/usecases/eating/add_meals.dart';
import 'package:calorify/features/splash/presentation/pages/splash_screen.dart';
import 'package:calorify/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/injection_container.dart';
import 'features/bottom_navigation/presentation/pages/custom_bottom_navigation_view.dart';
import 'features/food_page/data/datasources/open_food_facts_api_service.dart';
import 'data/models/adapters/product_model_adapter.dart';
import 'data/models/product_model.dart';
import 'features/home/domain/usecases/eating/get_meals.dart';
import 'features/home/presentation/bloc/meal/food/food_block.dart';
import 'features/home/presentation/bloc/meal/meal_state.dart';
import 'features/home/presentation/bloc/sport/sport_state.dart';
import 'features/home/presentation/bloc/water/water_state.dart';
import 'features/home/presentation/widgets/analitik_tab/food/grid_food.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ProductModel>('historyBox');
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
          child: GridFood(),
        ),
        BlocProvider<SportCubit>(
            create: (context) => SportCubit()
        ),
        BlocProvider<WaterCubit>(
            create: (context) => WaterCubit()
        ),
        BlocProvider<FoodSearchBloc>(
          create: (context) => FoodSearchBloc(OpenFoodFactsApiService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: CustomBottomNavigationView(),
      ),
    );
  }
}
