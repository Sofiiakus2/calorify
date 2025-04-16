import 'package:calorify/features/auth/presentation/pages/register.dart';
import 'package:calorify/shared/presentation/widgets/custom_elevated_button.dart';
import 'package:calorify/shared/presentation/widgets/shared_text_field.dart';
import 'package:flutter/material.dart';

///page for entering
class Enter extends StatefulWidget {
  ///
  const Enter({super.key});

  @override
  State<Enter> createState() => _EnterState();
}

class _EnterState extends State<Enter> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Вхід',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 30,),
              SharedTextField(
                hintText: 'Email',
                controller: _emailController,
                icon: const Icon(Icons.email_outlined),
                isError: false,
              ),
              const SizedBox(height: 15,),
              SharedTextField(
                hintText: 'Пароль',
                controller: _passwordController,
                icon: const Icon(Icons.password),
                isError: false,
              ),
              const SizedBox(height: 30,),
              CustomElevatedButton(
                  text: 'Увійти',
                  onPressed: (){

                  }),
              const SizedBox(height: 10,),
              TextButton(
                child: Text(  'Ще немає акаунту? Зареєструватись',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.grey.shade300),
                  textAlign: TextAlign.center,),
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder:
                        (context) => const Register(),),);
                },
              ),

            ],
          ),
        ),
    );
  }
}
