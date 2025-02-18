import 'package:calorify/features/bottom_navigation/custom_bottom_navigation_view.dart';
import 'package:calorify/features/home/home_app_bar/home_app_bar_view.dart';
import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';

import 'calories_chart/calories_chart.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeAppBarView(),
          CalorieChart(),
        ],
      ),
    );
  }
}
