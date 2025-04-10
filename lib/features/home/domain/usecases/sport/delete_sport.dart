import 'package:calorify/features/home/domain/entities/sport.dart';
import 'package:calorify/features/home/domain/repositories/sport_repository.dart';

///use case for deleting sport
class DeleteSport{
  final SportRepository repository;

  ///Constructor for the `DeleteSport` use case.
  DeleteSport(this.repository);

  ///Executes the logic for deleting a sport from the repository.
  Future<void> call(Sport sport){
    return repository.deleteSport(sport);
  }
}
