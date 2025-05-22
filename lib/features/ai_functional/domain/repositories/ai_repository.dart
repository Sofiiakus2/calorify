import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/ai_functional/domain/entities/analyzed_meal.dart';

import 'package:image_picker/image_picker.dart';
import 'package:calorify/core/entities/my_product.dart';

abstract class AiRepository {
  Future<XFile?> pickImage();
  Future<String?> convertToBase64(XFile file);
  Future<String?> analyzeImageWithGemini(String base64Image);
  AnalyzedMeal parseAnalyzedMeal(String jsonString);
}
