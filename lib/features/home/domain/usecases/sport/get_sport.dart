import 'package:calorify/features/home/domain/entities/sport.dart';
import 'package:calorify/features/home/domain/repositories/sport_repository.dart';

///use case for getting sport
class GetSport{
  final SportRepository repository;

  ///Constructor for the `GetSport` use case.
  GetSport(this.repository);

  ///Executes the logic for getting a sport from the repository.
  Future<List<Sport>> call(){
    return repository.getSport();
  }
}
