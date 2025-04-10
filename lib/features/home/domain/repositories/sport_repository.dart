import 'package:calorify/features/home/domain/entities/sport.dart';

///Sport repository
abstract class SportRepository{
  ///method for getting sport list
  Future<List<Sport>> getSport();

  ///method for adding new sport to list
  Future<void> addSport(Sport sport);

  ///method for deleting sport from the list
  Future<void> deleteSport(Sport sport);
}
