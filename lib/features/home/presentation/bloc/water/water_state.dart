import 'package:bloc/bloc.dart';
import 'package:calorify/features/home/domain/usecases/water/add_water_to_db.dart';
import 'package:calorify/features/home/domain/usecases/water/remove_water_from_db.dart';

///Water State
class WaterState {
  final int glassesCount;
  final List<bool> isFilled;
  final int filledCount;

  ///Constructor
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

///Water Cubit
class WaterCubit extends Cubit<WaterState> {
  final AddWaterToDb addWaterToDb;
  final RemoveWaterFromDb removeWaterFromDb;

  // Кількість мілілітрів у одній склянці
  final int glassMilliliters;

  WaterCubit({
    required this.addWaterToDb,
    required this.removeWaterFromDb,
    this.glassMilliliters = 250,
  }) : super(
    WaterState(
      glassesCount: 12,
      isFilled: List<bool>.filled(12, false),
      filledCount: 0,
    ),
  );

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
    if (state.glassesCount <= 1) return;

    final newCount = state.glassesCount - 1;
    final updatedIsFilled = List<bool>.from(state.isFilled)..removeLast();
    emit(state.copyWith(
      glassesCount: newCount,
      isFilled: updatedIsFilled,
    ));
    _updateFilledCount(updatedIsFilled);
  }

  /// Метод, який змінює стан і зберігає у БД
  Future<void> toggleGlassFill(int index) async {
    final updatedIsFilled = List<bool>.from(state.isFilled);
    final isNowFilled = !updatedIsFilled[index];

    updatedIsFilled[index] = isNowFilled;
    emit(state.copyWith(isFilled: updatedIsFilled));

    // Поточна дата без часу
    final today = DateTime.now();

    if (isNowFilled) {
      await addWaterToDb(glassMilliliters, today);
    } else {
      await removeWaterFromDb(glassMilliliters, today);
    }

    _updateFilledCount(updatedIsFilled);
  }

  void _updateFilledCount(List<bool> isFilled) {
    final filledCount = isFilled.where((filled) => filled).length;
    emit(state.copyWith(filledCount: filledCount));
  }
}
