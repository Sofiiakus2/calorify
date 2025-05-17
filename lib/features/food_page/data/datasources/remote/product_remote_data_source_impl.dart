
import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/core/mappers/product_mapper.dart';
import 'package:calorify/features/food_page/data/datasources/remote/product_remote_data_source.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:calorify/features/home/data/models/product_for_meal_model.dart';
import 'package:calorify/features/home/domain/entities/meal.dart';
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
    try{
      final result = await OpenFoodAPIClient.searchProducts(
        null,
        ProductSearchQueryConfiguration(
          parametersList: [
            SearchTerms(terms: [name]),
            PageNumber(page: 1),
            PageSize(size: 5),
          ],
          language: OpenFoodFactsLanguage.UKRAINIAN,
          fields: [
            ProductField.NAME,
            ProductField.NUTRIMENTS,
          ],
          version: ProductQueryVersion.v3,
        ),
      );
      if (result.products != null && result.products!.isNotEmpty) {
        return result.products!.map(ProductMapper.fromApiProduct).toList();
      } else {
        throw Exception('Продукти з ім\'ям "$name" не знайдено.');
      }
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Future<void> saveProductToDb(MyProduct product, MealModel meal) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return;

    final dateKey = DateFormat('yyyy-MM-dd').format(meal.date);

    final userDoc = firestore.collection('users').doc(currentUser.uid);
    final dayDoc = userDoc.collection('days').doc(dateKey);

    await dayDoc.set({'exists': true}, SetOptions(merge: true));

    final mealTypePath = MealModel.getMealTypePath(meal.meal);
    final mealDoc = dayDoc.collection('meals').doc(mealTypePath);

    final batch = firestore.batch();

    final itemsCollection = mealDoc.collection('items');
    final newProductRef = itemsCollection.doc();
    final productModel = ProductForMealModel.fromEntity(product);
    batch.set(newProductRef, productModel.toMap());

    batch.set(mealDoc, {
      'meal': meal.meal.name,
      'iconName': meal.iconName,
      'calories': FieldValue.increment(product.energyKcal_saved ?? 0),
      'proteins': FieldValue.increment(product.protein_saved ?? 0),
      'fats': FieldValue.increment(product.fat_saved ?? 0),
      'carbohydrates': FieldValue.increment(product.carbohydrates_saved ?? 0),
      'isTodayOnly': meal.isTodayOnly,
      'date': meal.date.toIso8601String(),
    }, SetOptions(merge: true));

    final daySummaryRef = dayDoc.collection('totals').doc('summary');
    batch.set(daySummaryRef, {
      'calories': FieldValue.increment(product.energyKcal_saved ?? 0),
      'proteins': FieldValue.increment(product.protein_saved ?? 0),
      'fats': FieldValue.increment(product.fat_saved ?? 0),
      'carbohydrates': FieldValue.increment(product.carbohydrates_saved ?? 0),
    }, SetOptions(merge: true));

    await batch.commit();
  }


  @override
  Future<List<ProductForMealModel>> getProductsForMeal(String mealType, String dateKey) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return [];

    final itemsSnapshot = await firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('days')
        .doc(dateKey)
        .collection('meals')
        .doc(mealType)
        .collection('items')
        .get();

    return itemsSnapshot.docs
        .map((doc) => ProductForMealModel.fromMap(doc.data()))
        .toList();
  }


  Map<String, double> _emptySummary() => {
    'calories': 0.0,
    'proteins': 0.0,
    'fats': 0.0,
    'carbohydrates': 0.0,
  };

  MealModel _emptyModel(String meal) => MealModel(
      date: DateTime.now(),
      meal: MealType.values.firstWhere((e) => e.name ==meal),
      calories: 0,
      iconName: MealModel.getIcon(meal),
      colorBlock: MealModel.getColor(MealModel.getIcon(meal)),
      isTodayOnly: false,
      products: [],
      proteins: 0,
      fats: 0,
      carbs: 0);

  @override
  Future<MealModel?> getMealSummary(String mealType, String dateKey) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) return null;

    final docSnapshot = await firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('days')
        .doc(dateKey)
        .collection('meals')
        .doc(mealType)
        .get();

    final data = docSnapshot.data();
    if (data == null || !docSnapshot.exists) {
      return _emptyModel(mealType);
    }

    return MealModel.fromMap({
      ...data,
      //todo розширення - переглядати продукти
      // 'products': products.map((e) => e.toMap()).toList(),
    });
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
      'calories': (data['calories'] as num).toDouble(),
      'proteins': (data['proteins']as num).toDouble(),
      'fats': (data['fats']  as num).toDouble(),
      'carbohydrates': (data['carbohydrates'] as num).toDouble(),
    };
  }

}

