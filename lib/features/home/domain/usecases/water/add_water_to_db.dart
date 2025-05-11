import 'package:calorify/features/home/domain/repositories/water_repository.dart';

///use case for saving water
class AddWaterToDb{
  final WaterRepository repository;

  ///Constructor
  AddWaterToDb(this.repository);

  ///Executes the logic for saving water.
  Future<void> call(int milliliters, DateTime date){
    return repository.addWaterToDb(milliliters, date);
  }
}
