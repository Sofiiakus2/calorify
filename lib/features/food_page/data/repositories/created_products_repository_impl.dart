import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/data/datasources/local/product_local_data_source.dart';
import 'package:calorify/features/food_page/domain/entity/own_product.dart';
import 'package:calorify/features/food_page/domain/repositories/created_products_repository.dart';
import 'package:hive/hive.dart';
import 'package:openfoodfacts/openfoodfacts.dart' as open;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CreatedProductRepositoryImpl implements CreatedProductsRepository {
  static const String createdProductsBoxName = 'created_products';
  final ProductLocalDataSource _dataSource;

  CreatedProductRepositoryImpl(this._dataSource);

  @override
  Future<void> registerUserToFoodFacts(String password) async {
    open.OpenFoodAPIConfiguration.userAgent = open.UserAgent(
      name: 'calorify',
      version: '1.0.0',
      system: 'flutter',
    );


    final String userId = const Uuid().v4();

    final open.User user = open.User(
      userId: userId,
      password: password,
    );

    final open.SignUpStatus status = await open.OpenFoodAPIClient.register(
      user: user,
      name: 'Calorify User',
      email: '$userId@calorify.com',
    );

    if (status.status == 201) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('off_user_id', userId);
      await prefs.setString('off_user_password', password);
    } else {
      throw Exception('Не вдалося зареєструвати користувача в OpenFoodFacts');
    }
  }

  @override
  Future<void> saveOwnProduct(OwnProduct product) async {
    open.OpenFoodAPIConfiguration.userAgent = open.UserAgent(
      name: 'calorify',
      version: '1.0.0',
      system: 'flutter',
    );
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('off_user_id');
    final password = prefs.getString('off_user_password');

    if (userId == null || password == null) {
      throw Exception('Необхідно увійти в обліковий запис OpenFoodFacts для додавання продукту.');
    }

    final open.User user = open.User(userId: userId, password: password);

    final productInput = product.toOpenFoodFactsProduct();

    final open.Status status = await open.OpenFoodAPIClient.saveProduct(
      user,
      productInput,
     // uriHelper: open.UriProductHelper(domain: open.OpenFoodFactsDomain.OPENFOODFACTS),
    );

    if (status.status == 1) {
      print('✅ Продукт успішно додано: ${status.status}');
      final box = Hive.box<MyProduct>(createdProductsBoxName);
      final myProduct = MyProduct.mapOpenFoodProductToMyProduct(productInput);
      await box.add(myProduct);
      print('object');

    } else {
      print('❌ Помилка при додаванні продукту: ${status.error}');
      throw Exception('OpenFoodFacts повернув помилку: ${status.error}');
    }
  }

  @override
  Future<List<MyProduct>> getCreatedProductsFromBoxCreated() {
    return _dataSource.getCreatedProductsFromBoxCreated();
  }

}
