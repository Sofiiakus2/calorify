
import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/core/injection_container.dart';
import 'package:calorify/core/provider/user_provide.dart';
import 'package:calorify/features/food_page/data/datasources/local/product_local_data_source.dart';
import 'package:calorify/features/food_page/data/datasources/remote/product_remote_data_source.dart';
import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:calorify/features/home/data/models/product_for_meal_model.dart';

///Product repository implementation
class ProductRepositoryImpl extends ProductRepository{
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ///Constructor
  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
});

  @override
  Future<MyProduct> getProductByBarcode(String barcode) async {
    return remoteDataSource.getProductByBarcode(barcode);
  }

  @override
  Future<List<MyProduct>> getProductsByName(String name) async {
    return remoteDataSource.getProductsByName(name);
  }

  @override
  Future<void> saveProductToDb(MyProduct product, MealModel meal) async{
    return remoteDataSource.saveProductToDb(product , meal);
  }


  @override
  Future<List<MyProduct>> getProductsFromHistory() async{
    return localDataSource.getProductsFromHistory();
  }

  @override
  Future<void> saveProductToHistory(MyProduct product) async{
    return localDataSource.saveProductToHistory(product);
  }

  @override
  Future<double> recountLeftCalories(MyProduct product) async {
    final userProvider = sl<UserProvider>();

    const fallbackCalories = 0.0;

    final double currentLeft = userProvider.user.leftCalories ??
        (userProvider.user.calories?.toDouble() ?? fallbackCalories);


    final double updatedLeft = currentLeft + (product.energyKcal_saved ?? 0.0);

    userProvider.setLeftCalories(updatedLeft);

    return updatedLeft;
  }

  @override
  Future<Map<String, double>> getMealSummary(String mealType, String dateKey) {
    return remoteDataSource.getMealSummary(mealType, dateKey);
  }

  @override
  Future<List<ProductForMealModel>> getProductsForMeal(String mealType, String dateKey) {
    return remoteDataSource.getProductsForMeal(mealType, dateKey);
  }

  @override
  Future<Map<String, double>> getTotalDaySummary(String dateKey) {
    return remoteDataSource.getTotalDaySummary(dateKey);
  }





}
