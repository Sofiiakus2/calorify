import 'package:calorify/core/entities/my_user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  final MyUser _user = MyUser();

  MyUser get user => _user;

  ///setter for user goal
  void setGoal(String goal){
    _user.goal = goal;
    notifyListeners();
  }

  ///setter for user personal data to calculate calories
  void setPersonalData({
    required int age,
    required int weightKg,
    required int heightCm,
    required String gender,
    required String activity,
}) {
    _user.age = age;
    _user.weightKg = weightKg;
    _user.heightCm = heightCm;
    _user.gender = gender;
    _user.activity = activity;
    notifyListeners();
  }

  ///setter for calories
  void setCalories(int calories){
    _user.calories = calories;
    notifyListeners();
  }

  ///setter for register data
  void setRegisterData({
    required String name,
    required String email,
    required String password,
}){
    _user.name = name;
    _user.email = email;
    _user.password = password;
  }

}
