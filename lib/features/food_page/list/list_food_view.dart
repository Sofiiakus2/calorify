import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../state_management/meal/food/food_block.dart';
import '../../../../state_management/meal/food/food_state.dart';
import '../../../data/local/hive_history_service.dart';
import '../../../data/models/product_model.dart';
import 'list_element_view.dart';

class ListFoodView extends StatefulWidget {
  const ListFoodView({super.key});

  @override
  _ListFoodViewState createState() => _ListFoodViewState();
}

class _ListFoodViewState extends State<ListFoodView> {
  int? _selectedIndex;
  List<ProductModel> history = HistoryService().getHistory();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodSearchBloc, FoodSearchState>(
      builder: (context, state) {
        if( state is FoodSearchInitial){
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
                  isSelected: _selectedIndex == index,
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
