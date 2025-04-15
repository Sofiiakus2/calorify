import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/presentation/widgets/info_container.dart';
import 'package:calorify/features/food_page/presentation/widgets/list/weight_text_field.dart';
import 'package:calorify/features/home/presentation/bloc/meal/calories/calories_bloc.dart';
import 'package:calorify/features/home/presentation/bloc/meal/calories/calories_event.dart';
import 'package:calorify/features/home/presentation/bloc/meal/calories/calories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///widget to set calories
class CaloriesSettings extends StatelessWidget {
  final MyProduct product;

  ///
  const CaloriesSettings({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return CaloriesBloc(product);
      },
      child: _CaloriesSettingsContent(product: product),
    );
  }
}

class _CaloriesSettingsContent extends StatelessWidget {
  final MyProduct product;

  const _CaloriesSettingsContent({required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaloriesBloc, CaloriesState>(
        builder: (context, state){
          double calories = product.energyKcal_saved!;
          double fats = product.fat_saved!;
          double carbohydrates = product.carbohydrates_saved!;
          double proteins = product.protein_saved!;

          if (state is UpdateCaloriesState) {
            calories = state.calories;
            fats = state.fats;
            carbohydrates = state.carbohydrates;
            proteins = state.proteins;
          }

          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Змінити вагу продукту',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 5),
              WeightTextField(
                onChangedWeight: (value) {
                  context.read<CaloriesBloc>().add(CaloriesChangedEvent(value));
                },
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  InfoContainer(name: 'Калорії', count: double.parse(calories.toStringAsFixed(2))),
                  InfoContainer(name: 'Жири', count: double.parse(fats.toStringAsFixed(2))),
                ],
              ),
              Row(
                children: [
                  InfoContainer(name: 'Вуглеводи', count: double.parse(carbohydrates.toStringAsFixed(2))),
                  InfoContainer(name: 'Білки', count: double.parse(proteins.toStringAsFixed(2))),
                ],
              ),
            ],
          );
        }
    );
  }
}