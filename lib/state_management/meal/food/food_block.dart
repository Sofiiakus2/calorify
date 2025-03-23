import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/api_service.dart';
import 'food_event.dart';
import 'food_state.dart';


class FoodSearchBloc extends Bloc<FoodSearchEvent, FoodSearchState> {
  final OpenFoodFactsApiClass api;

  FoodSearchBloc(this.api) : super(FoodSearchInitial()) {
    on<SearchFood>(_onSearchFood);
  }

  Future<void> _onSearchFood(SearchFood event, Emitter<FoodSearchState> emit) async {
    if (event.query.isEmpty) {
      emit(FoodSearchInitial());
      return;
    }

    emit(FoodSearchLoading());

    try {
      await for (final products in api.searchProductsByName(event.query)) {
        emit(FoodSearchSuccess(products));
      }
    } catch (e) {
      emit(FoodSearchFailure(e.toString()));
    }
  }
}
