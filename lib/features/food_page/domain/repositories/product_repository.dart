
import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:calorify/features/home/data/models/product_for_meal_model.dart';

///Product Repository
abstract class ProductRepository{
  ///method for getting product list by name
  Future<List<MyProduct>> getProductsByName(String name);

  ///method for getting product list by barcode
  Future<MyProduct> getProductByBarcode(String barcode);

  ///method for getting product history
  Future<List<MyProduct>> getProductsFromHistory();

  ///method for saving product to hive history of searching products
  Future<void> saveProductToHistory(MyProduct product);

  ///method for saving product to db
  Future<void> saveProductToDb(MyProduct product, MealModel meal);

  Future <double> recountLeftCalories(MyProduct product);


  Future<List<ProductForMealModel>> getProductsForMeal(String mealType, String dateKey) ;

  Future<MealModel?> getMealSummary(String mealType, String dateKey) ;

  Future<Map<String, double>> getTotalDaySummary(String dateKey) ;


}
