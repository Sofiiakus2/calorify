import 'dart:async';

import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/domain/usecases/created_products/get_created_products_from_hive.dart';
import 'package:calorify/features/food_page/domain/usecases/product/get_product_by_barcode.dart';
import 'package:calorify/features/food_page/domain/usecases/product/get_products_by_name.dart';
import 'package:calorify/features/food_page/domain/usecases/product/get_products_from_history.dart';
import 'package:calorify/features/food_page/domain/usecases/product/save_product_to_history.dart';
import 'package:calorify/features/food_page/presentation/bloc/food/food_event.dart';
import 'package:calorify/features/food_page/presentation/bloc/food/food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///bloc
class FoodBlock extends Bloc<FoodEvent, FoodSearchState> {
  final GetProductsByName getProductsByName;
  final GetProductByBarcode getProductByBarcode;
  final SaveProductToHistory saveProductToHistory;
  final GetProductsFromHistory getProductsFromHistory;
  final GetCreatedProductsFromHive getCreatedProductsFromHive;
  List<MyProduct> currentProducts = [];
  List<MyProduct> currentCreatedProducts = [];

  ///Constructor
  FoodBlock({
    required this.getProductsByName,
    required this.getProductByBarcode,
    required this.saveProductToHistory,
    required this.getProductsFromHistory,
    required this.getCreatedProductsFromHive,
  }) : super(FoodSearchInitial()) {
    on<SearchFood>(_onSearchFood);
    on<AddProductFromBarcode>(_onAddProductFromBarcode);
    on<LoadHistory>(_onLoadHistory);
  }

  Future<void> _onSearchFood(SearchFood event, Emitter<FoodSearchState> emit) async {

    if (event.query.isEmpty) {
      emit(FoodSearchInitial());
    }

    emit(FoodSearchLoading());

    try {
      currentProducts.clear();
      final products = await getProductsByName(event.query);
      currentProducts.addAll(products);
      emit(FoodSearchSuccess(List.from(currentProducts)));
    } catch (e) {
      emit(FoodSearchFailure(e.toString()));
    }
  }

  Future<void> _onAddProductFromBarcode(AddProductFromBarcode event, Emitter<FoodSearchState> emit) async {
    try{
      final product =
          await getProductByBarcode(event.barcode);
      currentProducts.insert(0, product);

      await saveProductToHistory(product);

      emit(FoodSearchSuccess(List.from(currentProducts), selectedIndex: 0));
    }catch (e) {
      emit(FoodSearchFailure("Failed to add product: ${e.toString()}"));
    }
  }
  //
  // Future<void> _onLoadHistory(LoadHistory event, Emitter<FoodSearchState> emit) async {
  //   emit(FoodSearchLoading());
  //   try {
  //     currentProducts = await getProductsFromHistory();
  //     emit(FoodSearchSuccess(List.from(currentProducts)));
  //   } catch (e) {
  //     emit(FoodSearchFailure(e.toString()));
  //   }
  // }

  Future<void> _onLoadHistory(LoadHistory event, Emitter<FoodSearchState> emit) async {
    emit(FoodSearchLoading());
    try {
      if (event.created) {
        currentCreatedProducts = await getCreatedProductsFromHive();
        emit(FoodSearchSuccess(List.from(currentCreatedProducts)));
      } else {
        currentProducts = await getProductsFromHistory();
        emit(FoodSearchSuccess(List.from(currentProducts)));
      }
    } catch (e) {
      emit(FoodSearchFailure(e.toString()));
    }
  }



}
