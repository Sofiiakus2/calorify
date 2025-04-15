///User entity
class MyUser{
  String? id;
  String? name;
  String? email;
  int? age;
  int? weightKg;
  int? heightCm;
  String? gender;
  String? activity;
  String? goal;

  ///Constructor
  MyUser({
    this.id,
    this.name,
    this.email,
    this.age,
    this.weightKg,
    this.heightCm,
    this.gender,
    this.activity,
    this.goal,
});

  ///copy with method
  MyUser copyWith({
    String? id,
    String? name,
    String? email,
    int? age,
    int? weightKg,
    int? heightCm,
    String? gender,
    String? activity,
    String? goal,
  }) {
    return MyUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      gender: gender ?? this.gender,
      activity: activity ?? this.activity,
      goal: goal ?? this.goal,
    );
  }
}
