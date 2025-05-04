import 'dart:ffi';

import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/core/mappers/product_mapper.dart';
import 'package:calorify/features/food_page/data/datasources/remote/product_remote_data_source.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:calorify/features/home/data/models/product_for_meal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

///remove data source implementation
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<MyProduct> getProductByBarcode(String barcode) async {
    final config = ProductQueryConfiguration(
      barcode,
      language: OpenFoodFactsLanguage.GERMAN,
      fields: [ProductField.ALL],
      version: ProductQueryVersion.v3,
    );

    final result = await OpenFoodAPIClient.getProductV3(config);

    if (result.status == ProductResultV3.statusSuccess) {
      return ProductMapper.fromApiProduct(result.product!);
    } else {
      throw Exception('Продукт не знайдено: $barcode');
    }
  }

  @override
  Future<List<MyProduct>> getProductsByName(String name) async {
    final result = await OpenFoodAPIClient.searchProducts(
      null,
      ProductSearchQueryConfiguration(
        parametersList: [SearchTerms(terms: [name])],
        language: OpenFoodFactsLanguage.ENGLISH,
        fields: [ProductField.ALL],
        version: ProductQueryVersion.v3,
      ),
    );
    if (result.products != null && result.products!.isNotEmpty) {
      return result.products!.map(ProductMapper.fromApiProduct).toList();
    } else {
      throw Exception('Продукти з ім\'ям "$name" не знайдено.');
    }
  }
  @override
  Future<void> saveProductToDb(MyProduct product, MealModel meal) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return;

    final dateKey = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final userDoc = firestore.collection('users').doc(currentUser.uid);
    final dayDoc = userDoc.collection('days').doc(dateKey);
    final mealPath = 'meals/${MealModel.getMealTypePath(meal.meal)}';
    final itemsCollection = dayDoc.collection('$mealPath/items');

    // Додаємо продукт
    final productMap = ProductForMealModel.fromEntity(product).toMap();
    await itemsCollection.add(productMap);

    // Оновлюємо summary для цього meal
    final mealSummaryRef = dayDoc.collection('meals').doc(MealModel.getMealTypePath(meal.meal));
    await mealSummaryRef.set({
      'calories': FieldValue.increment(product.energyKcal_saved!),
      'proteins': FieldValue.increment(product.protein_saved!),
      'fats': FieldValue.increment(product.fat_saved!),
      'carbohydrates': FieldValue.increment(product.carbohydrates_saved!),
    }, SetOptions(merge: true));

    // Оновлюємо загальні totals за день
    final totalsRef = dayDoc.collection('totals').doc('summary');
    await totalsRef.set({
      'calories': FieldValue.increment(product.energyKcal_saved!),
      'proteins': FieldValue.increment(product.protein_saved!),
      'fats': FieldValue.increment(product.fat_saved!),
      'carbohydrates': FieldValue.increment(product.carbohydrates_saved!),
    }, SetOptions(merge: true));
  }

  Future<List<ProductForMealModel>> getProductsForMeal(String mealType, String dateKey) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return [];

    final snapshot = await firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('days')
        .doc(dateKey)
        .collection('meals')
        .doc(mealType)
        .collection('items')
        .get();

    return snapshot.docs.map((doc) => ProductForMealModel.fromMap(doc.data())).toList();
  }

  Map<String, double> _emptySummary() => {
    'calories': 0.0,
    'proteins': 0.0,
    'fats': 0.0,
    'carbohydrates': 0.0,
  };


  Future<Map<String, double>> getMealSummary(String mealType, String dateKey) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return _emptySummary();

    final doc = await firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('days')
        .doc(dateKey)
        .collection('meals')
        .doc(mealType)
        .get();

    if (!doc.exists) return _emptySummary();

    final data = doc.data()!;

    return {
      'calories': data['calories'] as double,
      'proteins': data['proteins']as double,
      'fats': data['fats']  as double,
      'carbohydrates': data['carbohydrates'] as double,
    };
  }

  Future<Map<String, double>> getTotalDaySummary(String dateKey) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return _emptySummary();

    final doc = await firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('days')
        .doc(dateKey)
        .collection('totals')
        .doc('summary')
        .get();

    if (!doc.exists) return _emptySummary();

    final data = doc.data()!;

    return {
      'calories': data['calories'] as double,
      'proteins': data['proteins']as double,
      'fats': data['fats']  as double,
      'carbohydrates': data['carbohydrates'] as double,
    };
  }



}

