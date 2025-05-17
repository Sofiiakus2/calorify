import 'package:equatable/equatable.dart';


///Events
abstract class FoodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

///search
class SearchFood extends FoodEvent {
  final String query;

  @override
  List<Object?> get props => [query];

  ///Constructor
  SearchFood(this.query);

}


///add product
class AddProductFromBarcode extends FoodEvent {
  final String barcode;

  @override
  List<Object?> get props => [barcode];

  ///Constructor
  AddProductFromBarcode(this.barcode);

}

///Load history
class LoadHistory extends FoodEvent {
  final bool created;

  LoadHistory({this.created = false});
}

class LoadProductsWithPagination extends FoodEvent {
  final String name;
  final int page;
  final int pageSize;

  LoadProductsWithPagination({required this.name, required this.page, this.pageSize = 20});
}
