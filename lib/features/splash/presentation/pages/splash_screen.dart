import 'package:calorify/features/splash/presentation/pages/goal_page.dart';
import 'package:calorify/shared/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

///splash screen which shows only once, before registration
class SplashScreen extends StatelessWidget {
  ///
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             Text('Персоналізуйте ваш план харчування',
              style: Theme.of(context).textTheme.titleLarge,
             ),
              Image.asset('assets/images/avocado.png',
                width: 300,
              ),
              CustomElevatedButton(
                  text: 'Розпочати',
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const GoalPage()),
                    );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
