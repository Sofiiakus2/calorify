import 'package:calorify/features/home/domain/entities/sport.dart';
import 'package:calorify/features/home/domain/repositories/sport_repository.dart';

///use case for adding sport
class AddSport{
  final SportRepository repository;

  ///Constructor for the `AddSport` use case.
  AddSport(this.repository);

  ///Executes the logic for adding a sport to the repository.
  Future<void> call(Sport sport){
    return repository.addSport(sport);
  }
}
