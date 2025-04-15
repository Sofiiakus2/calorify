import 'package:calorify/core/entities/my_product.dart';
import 'package:equatable/equatable.dart';


///States
abstract class FoodSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

///Initial
class FoodSearchInitial extends FoodSearchState {}

///Loading
class FoodSearchLoading extends FoodSearchState {}

///Success
class FoodSearchSuccess extends FoodSearchState {
  final List<MyProduct> products;
  final int? selectedIndex;

  @override
  List<Object?> get props {
    return [products, selectedIndex];
  }

  ///Constructor
  FoodSearchSuccess(this.products, {this.selectedIndex});

}


///Failed
class FoodSearchFailure extends FoodSearchState {
  final String error;

  @override
  List<Object?> get props => [error];

  ///Constructor
  FoodSearchFailure(this.error);


}
