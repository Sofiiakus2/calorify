import 'package:calorify/data/models/user_model.dart';
import 'package:calorify/services/calorie_counter_service/calorie_counter.dart';
import 'package:flutter/material.dart';

import 'extra_widgets/custom_input_field.dart';
import 'extra_widgets/dropdown_field.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key, required this.goal});

  final String goal;

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late final TextEditingController ageController;
  late final TextEditingController weightController;
  late final TextEditingController heightController;

  String? selectedGender;
  String? selectedActivity;

  @override
  void initState() {
    super.initState();
    ageController = TextEditingController(text: '20');
    weightController = TextEditingController(text: '60');
    heightController = TextEditingController(text: '160');
  }

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (ageController.text.isNotEmpty &&
        weightController.text.isNotEmpty &&
        heightController.text.isNotEmpty &&
        selectedGender != null &&
        selectedActivity != null) {
      UserModel user = UserModel(
        goal: widget.goal,
        age: int.tryParse(ageController.text) ?? 0,
        weightKg: int.tryParse(weightController.text) ?? 0,
        heightCm: int.tryParse(heightController.text) ?? 0,
        gender: selectedGender,
        activity: selectedActivity,
      );

      CalorieCounter().calculateCalories(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Ваші дані', style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge),
              InputField(label: "Вік", controller: ageController),
              DropdownField(
                label: "Стать",
                items: ["Жінка", "Чоловік"],
                selectedValue: selectedGender,
                onChanged: (value) => setState(() => selectedGender = value),
              ),
              InputField(label: "Вага/кг", controller: weightController),
              InputField(label: "Зріст/см", controller: heightController),
              DropdownField(
                label: "Активність",
                items: ["Сидячий", "Малоактивний", "Активний", "Дуже активний"],
                selectedValue: selectedActivity,
                onChanged: (value) => setState(() => selectedActivity = value),
              ),
              Text(
                'Ми використовуємо цю інформацію для підрахунку ваших денних рекомендацій',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.grey.shade300),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: _validateAndSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 20),
                ),
                child: Text('Підрахувати',
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w800)),
              )
            ],
          ),
        ),
      ),
    );
  }
}