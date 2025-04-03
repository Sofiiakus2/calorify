import 'package:calorify/features/bottom_navigation/custom_bottom_navigation_view.dart';
import 'package:calorify/features/splash/splash_screen.dart';
import 'package:calorify/state_management/meal/meal_state.dart';
import 'package:calorify/state_management/sport/sport_state.dart';
import 'package:calorify/state_management/water/water_state.dart';
import 'package:calorify/state_management/meal/food/food_block.dart';
import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'api/api_service.dart';
import 'data/models/adapters/product_model_adapter.dart';
import 'data/models/product_model.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
            create: (context) => MealCubit()
        ),
        BlocProvider<SportCubit>(
            create: (context) => SportCubit()
        ),
        BlocProvider<WaterCubit>(
            create: (context) => WaterCubit()
        ),
        BlocProvider<FoodSearchBloc>(
          create: (context) => FoodSearchBloc(OpenFoodFactsApiClass()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: SplashScreen(),//CustomBottomNavigationView(),
      ),
    );
  }
}
