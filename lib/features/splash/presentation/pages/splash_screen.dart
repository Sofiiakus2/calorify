import 'package:calorify/core/injection_container.dart';
import 'package:calorify/core/provider/user_provide.dart';
import 'package:calorify/features/auth/domain/usecases/get_user_by_id.dart';
import 'package:calorify/features/bottom_navigation/presentation/pages/custom_bottom_navigation_view.dart';
import 'package:calorify/features/splash/presentation/pages/goal_page.dart';
import 'package:calorify/shared/presentation/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///splash screen which shows only once, before registration
class SplashScreen extends StatefulWidget {
  ///
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {

      await context.read<UserProvider>().loadUser(user.uid);

      await Navigator.pushReplacement(context,
      MaterialPageRoute(
          builder: (context) => const CustomBottomNavigationView()),
      );
    }
  }

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
