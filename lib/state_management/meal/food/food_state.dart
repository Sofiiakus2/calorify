import 'package:equatable/equatable.dart';

import '../../../data/models/product_model.dart';

abstract class FoodSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FoodSearchInitial extends FoodSearchState {}

class FoodSearchLoading extends FoodSearchState {}

class FoodSearchSuccess extends FoodSearchState {
  final List<ProductModel> products;

  FoodSearchSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class FoodSearchFailure extends FoodSearchState {
  final String error;

  FoodSearchFailure(this.error);

  @override
  List<Object?> get props => [error];
}
