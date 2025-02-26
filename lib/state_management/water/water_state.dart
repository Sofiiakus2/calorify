import 'package:bloc/bloc.dart';

class WaterState {
  final int glassesCount;
  final List<bool> isFilled;
  final int filledCount;

  WaterState({
    required this.glassesCount,
    required this.isFilled,
    required this.filledCount,
  });

  WaterState copyWith({
    int? glassesCount,
    List<bool>? isFilled,
    int? filledCount,
  }) {
    return WaterState(
      glassesCount: glassesCount ?? this.glassesCount,
      isFilled: isFilled ?? this.isFilled,
      filledCount: filledCount ?? this.filledCount,
    );
  }
}

class WaterCubit extends Cubit<WaterState> {
  WaterCubit()
      : super(WaterState(
    glassesCount: 12,
    isFilled: List<bool>.filled(12, false),
    filledCount: 0,
  ));

  void addGlass() {
    final newCount = state.glassesCount + 1;
    final updatedIsFilled = List<bool>.from(state.isFilled)..add(false);
    emit(state.copyWith(
      glassesCount: newCount,
      isFilled: updatedIsFilled,
    ));
    _updateFilledCount(updatedIsFilled);
  }

  void removeGlass() {
    if (state.glassesCount > 1) {
      final newCount = state.glassesCount - 1;
      final updatedIsFilled = List<bool>.from(state.isFilled)..removeLast();
      emit(state.copyWith(
        glassesCount: newCount,
        isFilled: updatedIsFilled,
      ));
      _updateFilledCount(updatedIsFilled);
    }
  }

  void toggleGlassFill(int index) {
    final updatedIsFilled = List<bool>.from(state.isFilled);
    updatedIsFilled[index] = !updatedIsFilled[index];
    emit(state.copyWith(isFilled: updatedIsFilled));
    _updateFilledCount(updatedIsFilled);
  }

  void _updateFilledCount(List<bool> isFilled) {
    final filledCount = isFilled.where((filled) => filled).length;
    emit(state.copyWith(filledCount: filledCount));
  }
}
