import 'package:calorify/features/home/domain/repositories/water_repository.dart';

///use case for getting water
class GetWaterForDay{
  final WaterRepository repository;

  ///Constructor
  GetWaterForDay(this.repository);

  ///Executes the logic for getting water.
  Future<void> call(DateTime date){
    return repository.getWaterForDay(date);
  }
}
