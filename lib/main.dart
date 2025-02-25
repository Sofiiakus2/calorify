import 'package:calorify/features/bottom_navigation/custom_bottom_navigation_view.dart';
import 'package:calorify/features/home/home_page_view.dart';
import 'package:calorify/state_management/meal/meal_state.dart';
import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: CustomBottomNavigationView(),
      ),
    );
  }
}
