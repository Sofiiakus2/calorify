import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/ai_functional/domain/entities/analyzed_meal.dart';

import 'package:image_picker/image_picker.dart';

abstract class LocalAiDataSource {
  Future<XFile?> pickImage();
  Future<String?> convertToBase64(XFile file);
  AnalyzedMeal parseAnalyzedMeal(String jsonString);
}
