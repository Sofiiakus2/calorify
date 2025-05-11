abstract class WaterRepository{
  Future<void> addWaterToDb(int milliliters, DateTime date) ;

  Future<int> getWaterForDay(DateTime date);

  Future<void> removeWaterFromDb(int milliliters, DateTime date);
}