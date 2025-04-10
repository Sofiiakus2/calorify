
import 'package:calorify/features/home/domain/entities/sport.dart';
import 'package:calorify/features/home/domain/usecases/sport/add_sport.dart';
import 'package:calorify/features/home/domain/usecases/sport/delete_sport.dart';
import 'package:calorify/features/home/domain/usecases/sport/get_sport.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///State for Sport
class SportState {
  final List<Sport> sport;

  ///Constructor
  SportState({required this.sport});
}

///Cubit for sport updates
class SportCubit extends Cubit<SportState> {
  final GetSport getSport;
  final AddSport addSport;
  final DeleteSport deleteSport;

  ///Constructor
  SportCubit({
    required this.getSport, required this.addSport, required this.deleteSport})
      :super(SportState(sport: []));

  ///method for loading sport State
  Future<void> loadSport() async{
    final sport = await getSport();
    emit(SportState(sport: sport));
  }

  ///method for adding new sport and update State
  Future<void> add(Sport sport) async{
    await addSport(sport);
    await loadSport();
  }

  ///method for deleting sport and update State
  Future<void> delete(Sport sport) async{
    await deleteSport(sport);
    await loadSport();
  }

}
