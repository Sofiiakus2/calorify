import 'package:calorify/features/splash/presentation/pages/goal_page.dart';
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
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => GoalPage()),
              );            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            ),
            child: Text(
              'Розпочати',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
