import 'package:calorify/core/entities/my_user.dart';

class CalorieCounter{

  void calculateCalories(MyUser user){
    double bmr;
    if (user.gender?.toLowerCase() == "чоловік") {
      bmr = 10 * user.weightKg! + 6.25 * user.heightCm! - 5 * user.age! + 5;
    } else {
      bmr = 10 * user.weightKg! + 6.25 * user.heightCm! - 5 * user.age! - 161;
    }

    double activityMultiplier;
    switch (user.activity) {
      case "Сидячий":
        activityMultiplier = 1.2;
        break;
      case "Малоактивний":
        activityMultiplier = 1.375;
        break;
      case "Активний":
        activityMultiplier = 1.55;
        break;
      case "Дуже активний":
        activityMultiplier = 1.725;
        break;
      default:
        activityMultiplier = 1.2;
    }

    double dailyCalories = bmr * activityMultiplier;

    print(dailyCalories);
}

}