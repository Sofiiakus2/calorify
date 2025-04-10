import 'package:equatable/equatable.dart';

import '../../../../../../data/models/product_model.dart';


abstract class FoodSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FoodSearchInitial extends FoodSearchState {}

class FoodSearchLoading extends FoodSearchState {}

class FoodSearchSuccess extends FoodSearchState {
  final List<ProductModel> products;
  final int? selectedIndex;

  FoodSearchSuccess(this.products, {this.selectedIndex});

  @override
  List<Object?> get props => [products, selectedIndex];
}

class FoodSearchFailure extends FoodSearchState {
  final String error;

  FoodSearchFailure(this.error);

  @override
  List<Object?> get props => [error];
}
