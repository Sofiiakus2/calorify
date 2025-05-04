import 'package:calorify/features/food_page/presentation/bloc/food/food_block.dart';
import 'package:calorify/features/food_page/presentation/bloc/food/food_state.dart';
import 'package:calorify/features/food_page/presentation/widgets/list/list_element_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///list of food
class ListFoodView extends StatefulWidget {
  ///
  const ListFoodView({super.key});

  @override
  _ListFoodViewState createState() => _ListFoodViewState();
}

class _ListFoodViewState extends State<ListFoodView> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBlock, FoodSearchState>(
      builder: (context, state) {
        int? selectedIndex;
          if (state is FoodSearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FoodSearchSuccess) {
          selectedIndex = state.selectedIndex ?? _selectedIndex;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: ListElementView(
                  product: state.products[index],
                  isSelected: selectedIndex == index,
                ),
              );
            },
          );
        }

        return const Center(child: Text('Введіть назву продукту для пошуку'));
      },
    );
  }
}
