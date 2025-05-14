/// Sport Entity
class Sport {
  int id;
  String name;
  int calories;
  String iconName;

  /// Constructor
  Sport({
    required this.id,
    required this.name,
    required this.calories,
    required this.iconName,
  });

  /// Create Sport from JSON (Map)
  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
      id: json['id'] as int,
      name: json['name'] as String,
      calories: json['calories'] as int,
      iconName: json['iconName'] as String,
    );
  }

  /// Convert Sport to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'iconName': iconName,
    };
  }
}
