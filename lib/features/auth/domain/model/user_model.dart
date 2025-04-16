import 'package:calorify/core/entities/my_user.dart';

///user model
class UserModel extends MyUser{
  ///Constructor
  UserModel({
    super.id,
    super.name,
    super.email,
    super.age,
    super.weightKg,
    super.heightCm,
    super.gender,
    super.activity,
    super.goal,
    super.calories,
});

  factory UserModel.fromMyUser(MyUser user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      age: user.age,
      weightKg: user.weightKg,
      heightCm: user.heightCm,
      gender: user.gender,
      activity: user.activity,
      goal: user.goal,
      calories: user.calories,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      id: map['id'] as String?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      age: map['age'] as int?,
      weightKg: map['weightKg'] as int?,
      heightCm: map['heightCm'] as int?,
      gender: map['gender'] as String?,
      activity: map['activity'] as String?,
      goal: map['goal'] as String?,
      calories: map['calories'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'weightKg': weightKg,
      'heightCm': heightCm,
      'gender': gender,
      'activity': activity,
      'goal': goal,
      'calories': calories,
    };
  }


}
