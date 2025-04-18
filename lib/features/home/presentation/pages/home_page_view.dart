
import 'package:calorify/features/home/presentation/widgets/analitik_tab/analitik_tab_bar.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/food/grid_food.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/sport/grid_sport.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/water/water_tracker.dart';
import 'package:calorify/features/home/presentation/widgets/calories_chart/calories_chart.dart';
import 'package:calorify/features/home/presentation/widgets/home_app_bar_view.dart';
import 'package:flutter/material.dart';


///Home Page
class HomePageView extends StatefulWidget {
  ///
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeAppBarView(),
          const SizedBox(height: 10,),
          SizedBox(
              width: double.infinity,
              height: 200,
              child: Stack(
                children: [
                  const Center(child: CalorieChart()),
                  Positioned(
                      left: 40,
                      top: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('План',
                              style: Theme.of(context).textTheme.labelSmall),
                          Text('1900 ккал',
                              style: Theme.of(context).textTheme.labelMedium),
                        ],
                      )
                  ),
                  Positioned(
                      right: 40,
                      top: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Лишилося',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12)),
                          Text('500 ккал',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 16)),
                        ],
                      )
                  ),
                ],
              )
          ),
          SizedBox(height: 35,),
          AnalitikTabBar(tabController: _tabController),
          SizedBox(height: 10,),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
               GridFood(),
               GridSport(),
               WaterTracker()
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

