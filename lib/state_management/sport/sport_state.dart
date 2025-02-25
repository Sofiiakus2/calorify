import 'package:bloc/bloc.dart';
import 'package:calorify/models/sport_model.dart';

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
}
