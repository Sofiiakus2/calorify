import 'package:image_picker/image_picker.dart';
import 'package:calorify/features/ai_functional/domain/repositories/ai_repository.dart';

class PickImageUseCase {
  final AiRepository _repository;

  PickImageUseCase(this._repository);

  Future<XFile?> call() => _repository.pickImage();
}
