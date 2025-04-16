import 'package:calorify/core/provider/user_provide.dart';
import 'package:calorify/features/auth/presentation/pages/enter.dart';
import 'package:calorify/features/auth/presentation/pages/register.dart';
import 'package:calorify/features/splash/domain/usecases/calculate_calories_usecase.dart';
import 'package:calorify/features/splash/presentation/widgets/custom_input_field.dart';
import 'package:calorify/features/splash/presentation/widgets/dropdown_field.dart';
import 'package:calorify/shared/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///screen with personal info. Uses for count calories
class PersonalInfoPage extends StatefulWidget {
  ///
  const PersonalInfoPage({super.key,});


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

    context.read<UserProvider>().setPersonalData(
      age: int.parse(ageController.text),
      weightKg: int.parse(weightController.text),
      heightCm: int.parse(heightController.text),
      gender: selectedGender.toString(),
      activity: selectedActivity.toString(),
    );

    final user = context.read<UserProvider>().user;

    context.read<UserProvider>().setCalories(
        CalculateCaloriesUseCase().execute(user).toInt(),);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Register()),
        (Route<dynamic> route) => false,
    );
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
              CustomElevatedButton(
                  text: 'Підрахувати',
                  onPressed: _validateAndSubmit,
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
