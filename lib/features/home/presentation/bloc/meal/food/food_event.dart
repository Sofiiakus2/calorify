import 'package:equatable/equatable.dart';

import '../../../../../../data/models/product_model.dart';


abstract class FoodSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchFood extends FoodSearchEvent {
  final String query;

  SearchFood(this.query);

  @override
  List<Object?> get props => [query];
}

class AddProductFromBarcode extends FoodSearchEvent {
  final ProductModel product;

  AddProductFromBarcode(this.product);

  @override
  List<Object?> get props => [product];
}