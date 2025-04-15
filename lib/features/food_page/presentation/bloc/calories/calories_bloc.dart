import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/presentation/bloc/calories/calories_event.dart';
import 'package:calorify/features/food_page/presentation/bloc/calories/calories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


///calories bloc
class CaloriesBloc extends Bloc<CaloriesEvent, CaloriesState>{
  final MyProduct product;

  ///constructor
  CaloriesBloc(this.product): super(const CaloriesInitial()){
    add(const CaloriesChangedEvent(100));
    on<CaloriesChangedEvent>(_caloriesChanged);
  }

  Future<void> _caloriesChanged(CaloriesChangedEvent e, Emitter emit) async {
    final double weight = e.weight;
    const double originalWeight = 100;

    final double calories = (product.energyKcal_100g / originalWeight) * weight;
    final double fats = (product.fat_100g / originalWeight) * weight;
    final double carbohydrates = (
        product.carbohydrates_100g / originalWeight) * weight;
    final double proteins = (product.protein_100g / originalWeight) * weight;

    emit(UpdateCaloriesState(
      calories: calories,
      fats: fats,
      carbohydrates: carbohydrates,
      proteins: proteins,
    ),);
  }
}