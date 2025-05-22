import 'dart:convert';
import 'package:calorify/features/ai_functional/domain/entities/analyzed_meal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:calorify/core/entities/my_product.dart';
import 'local_ai_data_source.dart';

class LocalAiDataSourceImpl implements LocalAiDataSource {
  @override
  Future<XFile?> pickImage() async {
    final picker = ImagePicker();

    return await picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Future<String?> convertToBase64(XFile file) async {
    final bytes = await file.readAsBytes();

    return base64Encode(bytes);
  }

  @override
  AnalyzedMeal parseAnalyzedMeal(String jsonString) {
    final cleanedJsonString = _cleanJson(jsonString);
    final Map<String, dynamic> jsonMap = jsonDecode(cleanedJsonString) as Map<String, dynamic>;

    final List<dynamic> productsJson = jsonMap['products'] as List<dynamic>;
    final Map<String, dynamic> totalsJson = jsonMap['totals'] as Map<String, dynamic>;

    final products = productsJson.map((productJson) {
      return MyProduct(
        name: productJson['name'] as String,
        barcode: '',
        energyKcal_100g: (productJson['caloriesTotal'] as num).toDouble(),
        protein_100g: (productJson['proteinsTotal'] as num).toDouble(),
        fat_100g: (productJson['fatsTotal'] as num).toDouble(),
        carbohydrates_100g: (productJson['carbohydratedTotal'] as num).toDouble(),
        sugar_100g: 0.0,
        weight: productJson['weight'] as String,
      );
    }).toList();

    final totals = Totals(
      totalCalories: (totalsJson['totalCalories'] as num).toDouble(),
      totalProteins: (totalsJson['totalProteins'] as num).toDouble(),
      totalFats: (totalsJson['totalFats'] as num).toDouble(),
      totalCarbohydrates: (totalsJson['totalCarbohydrates'] as num).toDouble(),
    );

    return AnalyzedMeal(products: products, totals: totals);
  }


  String _cleanJson(String raw) {
    return raw
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .trim();
  }

}
