import 'package:calorify/features/home/domain/entities/sport.dart';
import 'package:calorify/features/home/domain/repositories/sport_repository.dart';

///Sport repository Implementation
class SportRepositoryImpl extends SportRepository{
  final List<Sport> _sport = [
    Sport(id: 1, name: 'Ходьба', calories: 200, iconName: 'run'),
  ];

  @override
  Future<void> addSport(Sport sport) async{
    _sport.add(sport);
  }

  @override
  Future<void> deleteSport(Sport sport) async {
    _sport.removeWhere((element) => element.id == sport.id);
  }

  @override
  Future<List<Sport>> getSport() async{
    return _sport;
  }
}
