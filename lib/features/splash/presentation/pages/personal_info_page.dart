import 'package:calorify/core/entities/my_user.dart';
import 'package:calorify/features/splash/domain/repositories/calorie_counter.dart';
import 'package:calorify/features/splash/presentation/widgets/custom_input_field.dart';
import 'package:calorify/features/splash/presentation/widgets/dropdown_field.dart';
import 'package:flutter/material.dart';

///screen with personal info. Uses for count calories
class PersonalInfoPage extends StatefulWidget {
  ///
  const PersonalInfoPage({super.key, required this.goal});

  final String goal;

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController ageController = TextEditingController(text: '20');
  final TextEditingController weightController = TextEditingController(text: '60');
  final TextEditingController heightController = TextEditingController(text: '160');

  String? selectedGender;
  String? selectedActivity;


  void _validateAndSubmit() {
    if (ageController.text.isEmpty ||
        weightController.text.isEmpty ||
        heightController.text.isEmpty ||
        selectedGender == null ||
        selectedActivity == null) {
      return;
    }

    final MyUser user = MyUser(
      goal: widget.goal,
      age: int.tryParse(ageController.text) ?? 0,
      weightKg: int.tryParse(weightController.text) ?? 0,
      heightCm: int.tryParse(heightController.text) ?? 0,
      gender: selectedGender,
      activity: selectedActivity,
    );

    CalorieCounter().calculateCalories(user);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Ваші дані', style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge),
              InputField(label: "Вік", controller: ageController),
              DropdownField(
                label: "Стать",
                items: const ["Жінка", "Чоловік"],
                selectedValue: selectedGender,
                onChanged: (value) => setState(() => selectedGender = value),
              ),
              InputField(label: "Вага/кг", controller: weightController),
              InputField(label: "Зріст/см", controller: heightController),
              DropdownField(
                label: "Активність",
                items: const ["Сидячий", "Малоактивний", "Активний", "Дуже активний"],
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }
}
