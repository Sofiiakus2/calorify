///Meal Entity
class Meal{
  String meal;
  int calories;
  String iconName;
  bool isTodayOnly;

  ///Constructor
  Meal({
    required this.meal,
    required this.calories,
    required this.iconName,
    required this.isTodayOnly,
  });
}
