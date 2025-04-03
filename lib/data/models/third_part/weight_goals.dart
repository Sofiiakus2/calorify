class WeightGoal {
  final String title;
  final String imagePath;

  WeightGoal({required this.title, required this.imagePath});
}

List<WeightGoal> weightGoals = [
  WeightGoal(title: 'Скинути вагу', imagePath: 'broccoli'),
  WeightGoal(title: 'Утримувати вагу', imagePath: 'avocado'),
  WeightGoal(title: 'Набрати вагу', imagePath: 'meat'),
];