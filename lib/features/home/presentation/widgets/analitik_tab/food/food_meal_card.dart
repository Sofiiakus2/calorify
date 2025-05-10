import 'package:calorify/core/provider/bottom_nav_provider.dart';
import 'package:calorify/core/provider/selected_meal_provider.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:calorify/features/home/presentation/bloc/meal/meal_summary_cubit.dart';
import 'package:calorify/features/home/presentation/bloc/meal/meal_summary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

///meal card view
class MealCard extends StatefulWidget {
  final MealModel mealModel;
  final double calories;
  final String icon;
  final Color color;

  ///constructor
  const MealCard({
    super.key,
    required this.mealModel,
    required this.calories,
    required this.icon,
    required this.color,
  });

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  final MealSummaryCubit _cubit = GetIt.instance<MealSummaryCubit>();


  @override
  void initState() {
    super.initState();
   // final summaryProvider = context.read<MealSummaryProvider>();
    final dateKey = DateFormat('yyyy-MM-dd').format(DateTime.now());

    _cubit.loadMeal(widget.mealModel.meal.name, dateKey);
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MealSummaryCubit, MealSummaryState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is MealSummaryLoading) return const CircularProgressIndicator();
        if (state is MealSummaryLoaded) {
          final meal = state.meals[widget.mealModel.meal.name];

          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: widget.color,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Center(
                          child: Image.asset('assets/icons/food/${widget.icon}.png'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${meal?.calories.toStringAsFixed(0) ?? 0} ккал',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.mealModel.meal.name.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      IconButton(
                        onPressed: () {

                          context.read<SelectedMealProvider>().selectMeal(widget.mealModel);
                          if (context.read<BottomNavProvider>().currentIndex != 1) {
                            context.read<BottomNavProvider>().changeTab(1);
                          }
                        },
                        icon: const Icon(Icons.add, color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        return Text('Немає даних');
      },
    );
  }
}
