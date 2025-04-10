import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../food_page/data/datasources/api_service.dart';
import '../../../../../../data/models/product_model.dart';
import 'food_event.dart';
import 'food_state.dart';


class FoodSearchBloc extends Bloc<FoodSearchEvent, FoodSearchState> {
  final OpenFoodFactsApiClass api;
  List<ProductModel> currentProducts = [];

  FoodSearchBloc(this.api) : super(FoodSearchInitial()) {
    on<SearchFood>(_onSearchFood);
    on<AddProductFromBarcode>(_onAddProductFromBarcode);
  }

  Future<void> _onSearchFood(SearchFood event, Emitter<FoodSearchState> emit) async {
    if (event.query.isEmpty) {
      emit(FoodSearchInitial());
      return;
    }

    emit(FoodSearchLoading());

    try {
      currentProducts.clear();
      await for (final products in api.searchProductsByName(event.query)) {
        currentProducts.addAll(products);
      }
      emit(FoodSearchSuccess(List.from(currentProducts)));
    } catch (e) {
      emit(FoodSearchFailure(e.toString()));
    }
  }

  Future<void> _onAddProductFromBarcode(AddProductFromBarcode event, Emitter<FoodSearchState> emit) async {
    currentProducts.insert(0, event.product);
    emit(FoodSearchSuccess(List.from(currentProducts), selectedIndex: 0));
  }
}
