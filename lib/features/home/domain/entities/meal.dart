import 'package:calorify/features/home/data/models/product_for_meal_model.dart';

///Meal Entity
class Meal{
  String meal;
  int calories;
  String iconName;
  bool isTodayOnly;
  List<ProductForMealModel> products;

  ///Constructor
  Meal({
    required this.meal,
    required this.calories,
    required this.iconName,
    required this.isTodayOnly,
    required this.products,
  });

  Meal copyWith({
    String? meal,
    int? calories,
    String? iconName,
    bool? isTodayOnly,
    List<ProductForMealModel>? products,
  }) {
    return Meal(
      meal: meal ?? this.meal,
      calories: calories ?? this.calories,
      iconName: iconName ?? this.iconName,
      isTodayOnly: isTodayOnly ?? this.isTodayOnly,
      products: products ?? this.products,
    );
  }
}
