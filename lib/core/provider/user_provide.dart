import 'package:calorify/core/entities/my_user.dart';
import 'package:calorify/core/injection_container.dart';
import 'package:calorify/features/auth/domain/usecases/get_user_by_id.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  MyUser _user = MyUser();

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

  void setLeftCalories(double calories){
    _user.leftCalories = calories;
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

  ///setter for enter data
  void setEnterData({
    required String email,
    required String password,
  }){
    _user.email = email;
    _user.password = password;
  }

  ///clear user
  void clearUser() {
    _user = MyUser();
    notifyListeners();
  }

  ///Load user
  Future<void> loadUser(String uid) async {
    final getUserById = sl<GetUserById>();
    _user = await getUserById.call(uid);
    notifyListeners();
  }
}
