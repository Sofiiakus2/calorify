import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calorify/features/food_page/food_tab/list_element_view.dart';
import 'package:calorify/models/product_model.dart';

import '../../../state_management/meal/food/food_block.dart';
import '../../../state_management/meal/food/food_state.dart';

class ListFoodView extends StatelessWidget {
  const ListFoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
      builder: (context, state) {
        if (state is FoodSearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FoodSearchSuccess) {
          if (state.products.isEmpty) {
            return const Center(child: Text('Нічого не знайдено'));
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return ListElementView(product: state.products[index]);
            },
          );
        } else if (state is FoodSearchFailure) {
          return Center(child: Text(state.error, style: const TextStyle(color: Colors.red)));
        }
        return const Center(child: Text('Введіть назву продукту для пошуку'));
      },
    );
  }
}
