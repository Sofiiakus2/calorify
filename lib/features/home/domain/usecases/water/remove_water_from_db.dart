import 'package:calorify/features/home/domain/repositories/water_repository.dart';

class RemoveWaterFromDb{
  final WaterRepository waterRepository;

  RemoveWaterFromDb(this.waterRepository);

  Future<void> call (int milliliters, DateTime date){
    return waterRepository.removeWaterFromDb(milliliters, date);
  }
}