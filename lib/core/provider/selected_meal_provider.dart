
import 'package:calorify/features/home/data/models/daily_meal.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:flutter/material.dart';

///provider for adding products to Selected meal
class SelectedMealProvider extends ChangeNotifier{
    MealModel? _selectedMeal;

    MealModel? get selectedMeal => _selectedMeal;

    ///select meal
    void selectMeal(MealModel meal){
      _selectedMeal = meal;
      notifyListeners();
    }

    ///clear meal
    void clear() {
      _selectedMeal = null;
      notifyListeners();
    }
}
