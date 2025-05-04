import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/presentation/bloc/calories/calories_bloc.dart';
import 'package:calorify/features/food_page/presentation/bloc/calories/calories_event.dart';
import 'package:calorify/features/food_page/presentation/bloc/calories/calories_state.dart';
import 'package:calorify/features/food_page/presentation/widgets/info_container.dart';
import 'package:calorify/features/food_page/presentation/widgets/list/weight_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///widget to set calories
class CaloriesEditor extends StatelessWidget {
  final MyProduct product;

  ///
  const CaloriesEditor({required this.product, super.key});

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
          double calories = 0;
          double fats = 0;
          double carbohydrates = 0;
          double proteins = 0;

          if (state is UpdateCaloriesState) {
            calories = state.calories;
            fats = state.fats;
            carbohydrates = state.carbohydrates;
            proteins = state.proteins;

            product.energyKcal_saved = calories;
            product.fat_saved = fats;
            product.carbohydrates_saved = carbohydrates;
            product.protein_saved = proteins;
          } else {
            calories = product.energyKcal_saved ?? 0;
            fats = product.fat_saved ?? 0;
            carbohydrates = product.carbohydrates_saved ?? 0;
            proteins = product.protein_saved ?? 0;
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
        },
    );
  }
}
