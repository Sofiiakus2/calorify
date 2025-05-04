
import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:calorify/features/home/data/models/product_for_meal_model.dart';

///remote data source
abstract class ProductRemoteDataSource {
  ///method for getting one product by barcode
  Future<MyProduct> getProductByBarcode(String barcode);

  ///method for getting product list bu name
  Future<List<MyProduct>> getProductsByName(String name);

  Future<void> saveProductToDb(MyProduct product, MealModel meal);

  Future<List<ProductForMealModel>> getProductsForMeal(String mealType, String dateKey) ;

  Future<Map<String, double>> getMealSummary(String mealType, String dateKey) ;

  Future<Map<String, double>> getTotalDaySummary(String dateKey) ;


  }
