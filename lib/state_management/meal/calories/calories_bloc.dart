import 'package:bloc/bloc.dart';

import '../../../models/product_model.dart';
import 'calories_event.dart';
import 'calories_state.dart';

class CaloriesBloc extends Bloc<CaloriesEvent, CaloriesState>{
  final ProductModel product;

  CaloriesBloc(this.product): super(CaloriesInitial()){
    on<CaloriesEvent>(_caloriesEventHandler);
    on<CaloriesChangedEvent>(_caloriesChanged);
  }

  Future<void> _caloriesEventHandler (CaloriesEvent e, Emitter emit) async {
    emit(CaloriesInitial());
  }

  Future<void> _caloriesChanged(CaloriesChangedEvent e, Emitter emit) async {
    double weight = e.weight;
    double originalWeight = 100;
print(originalWeight);
    double calories = (product.energyKcal_100g / originalWeight) * weight;
    double fats = (product.fat_100g / originalWeight) * weight;
    double carbohydrates = (product.carbohydrates_100g / originalWeight) * weight;
    double proteins = (product.protein_100g! / originalWeight) * weight;

    emit(UpdateCaloriesState(
      calories: calories,
      fats: fats,
      carbohydrates: carbohydrates,
      proteins: proteins,
    ));
  }
}