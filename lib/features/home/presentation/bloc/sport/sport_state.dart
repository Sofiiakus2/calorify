import 'package:bloc/bloc.dart';

import '../../../domain/entities/sport_model.dart';

class SportState {
  final List<SportModel> activity;

  SportState({required this.activity});
}

class SportCubit extends Cubit<SportState> {
  SportCubit() : super(SportState(activity:activities));

  void addSport(SportModel act) {
    final updatedSport = List<SportModel>.from(state.activity)..add(act);
    emit(SportState(activity: updatedSport));
  }

  void removeSport(int id) {
    final updatedList = state.activity.where((sport) => sport.id != id).toList();
    emit(SportState(activity: updatedList));
  }
}
