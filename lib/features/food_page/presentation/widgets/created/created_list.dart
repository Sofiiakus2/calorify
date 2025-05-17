import 'package:calorify/features/food_page/presentation/bloc/food/food_block.dart';
import 'package:calorify/features/food_page/presentation/bloc/food/food_event.dart';
import 'package:calorify/features/food_page/presentation/bloc/food/food_state.dart';
import 'package:calorify/features/food_page/presentation/widgets/created/create_new_button.dart';
import 'package:calorify/features/food_page/presentation/widgets/list/list_element_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedList extends StatefulWidget {
  const CreatedList({super.key});

  @override
  State<CreatedList> createState() => _CreatedListState();
}

class _CreatedListState extends State<CreatedList> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    context.read<FoodBlock>().add(LoadHistory(created: true));

    return BlocBuilder<FoodBlock, FoodSearchState>(
        builder: (context, state) {
          int? selectedIndex;
          if (state is FoodSearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FoodSearchSuccess) {
            selectedIndex = state.selectedIndex ?? _selectedIndex;

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: state.products.length + 1,
              itemBuilder: (context, index) {
                if(index == state.products.length ) {
                  return const CreateNewButton();
                }

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: ListElementView(
                    product: state.products[index],
                    isSelected: selectedIndex == index,
                    isHistory: false,
                  ),
                );
                //   }
              },
            );
          }

          return const Center(child: Text('Введіть назву продукту для пошуку'));

        }
    );
  }
}
