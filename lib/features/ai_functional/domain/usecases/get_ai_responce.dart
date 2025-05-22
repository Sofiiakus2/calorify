import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/ai_functional/domain/entities/analyzed_meal.dart';
import 'package:calorify/features/ai_functional/domain/repositories/ai_repository.dart';
import 'package:image_picker/image_picker.dart';

class GetAiResponce {
  final AiRepository _repository;

  GetAiResponce(this._repository);

  Future<AnalyzedMeal> analyzeImageWithBase64(String base64) async {
    final json = await _repository.analyzeImageWithGemini(base64);
    if (json == null) {
      throw Exception("AI did not return a response");
    }
    return _repository.parseAnalyzedMeal(json);
  }

}
