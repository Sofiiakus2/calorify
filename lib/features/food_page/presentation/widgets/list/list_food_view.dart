import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/product_model.dart';

import '../../../../home/presentation/bloc/meal/food/food_block.dart';
import '../../../../home/presentation/bloc/meal/food/food_state.dart';
import '../../../data/local/hive_history_service.dart';
import 'list_element_view.dart';

class ListFoodView extends StatefulWidget {
  const ListFoodView({super.key});

  @override
  _ListFoodViewState createState() => _ListFoodViewState();
}

class _ListFoodViewState extends State<ListFoodView> {
  int? _selectedIndex;
  List<ProductModel> history = HiveHistoryService().getHistory();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
      builder: (context, state) {
        int? selectedIndex;
        if( state is FoodSearchInitial){
          selectedIndex = null;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: history.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: ListElementView(
                  product: history[index],
                  isSelected: _selectedIndex == index,
                ),
              );
            },
          );
        }
        else if (state is FoodSearchLoading) {
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
