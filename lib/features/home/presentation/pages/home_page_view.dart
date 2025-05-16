
import 'package:calorify/core/provider/user_provide.dart';
import 'package:calorify/features/home/presentation/bloc/meal/total_summary_cubit.dart';
import 'package:calorify/features/home/presentation/bloc/meal/total_summary_state.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/analitik_tab_bar.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/food/grid_food.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/sport/grid_sport.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/water/water_tracker.dart';
import 'package:calorify/features/home/presentation/widgets/calories_chart/calories_chart.dart';
import 'package:calorify/features/home/presentation/widgets/home_app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';


///Home Page
class HomePageView extends StatefulWidget {
  ///
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final TotalSummaryCubit _cubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _cubit = GetIt.instance<TotalSummaryCubit>();
    _cubit.loadTotal();
    _tabController.addListener(() {
      setState(() {});
    });
  }

  double eatenCalories = 0.0;
  Map<String, dynamic> _emptyTotals  = {
    'calories': 0.0,
    'proteins': 0.0,
    'fats': 0.0,
    'carbohydrates':0.0,
  };

  @override
  Widget build(BuildContext context) {
    final plannedCalories = context.read<UserProvider>().user.calories ?? 0;

    return Scaffold(
      body: Column(
        children: [
          const HomeAppBarView(),
          const SizedBox(height: 10,),
          BlocBuilder<TotalSummaryCubit, TotalSummaryState>(
            bloc: _cubit,
            builder: (context, state){
              final totals = state is TotalSummaryLoaded ? state.total : _emptyTotals;
              final double eatenCalories = totals['calories'] as double ?? 0;
              final remainingCalories = (plannedCalories - eatenCalories).clamp(0, double.infinity);

              return SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Stack(
                    children: [
                      Center(child: CaloriesChart(
                        totalCalories: plannedCalories,
                        remainingCalories: remainingCalories.toInt(),
                      )),
                      Positioned(
                        left: 40,
                        top: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('План',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelSmall,),
                            Text('$plannedCalories ккал',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Лишилося',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(fontSize: 12)),
                            Text('${remainingCalories.toStringAsFixed(0)} ккал',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
    }
          ),
          const SizedBox(height: 35,),
          AnalitikTabBar(tabController: _tabController),
          const SizedBox(height: 10,),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
               GridFood(
                   isDialog: false,
               ),
               GridSport(),
               WaterTracker(),
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

