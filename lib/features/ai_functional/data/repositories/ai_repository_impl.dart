import 'package:calorify/features/ai_functional/domain/entities/analyzed_meal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/ai_functional/data/datasources/local/local_ai_data_source.dart';
import 'package:calorify/features/ai_functional/data/datasources/remote/remote_ai_data_source.dart';
import 'package:calorify/features/ai_functional/domain/repositories/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {
  final LocalAiDataSource _local;
  final RemoteAiDataSource _remote;

  AiRepositoryImpl(this._local, this._remote);

  @override
  Future<XFile?> pickImage() => _local.pickImage();

  @override
  Future<String?> convertToBase64(XFile file) => _local.convertToBase64(file);

  @override
  Future<String?> analyzeImageWithGemini(String base64Image) =>
      _remote.analyzeImageWithGemini(base64Image);

  @override
  AnalyzedMeal parseAnalyzedMeal(String jsonString) =>
      _local.parseAnalyzedMeal(jsonString);


}
