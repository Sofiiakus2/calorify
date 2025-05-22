import 'package:calorify/core/injection_container.dart';
import 'package:calorify/core/provider/user_provide.dart';
import 'package:calorify/core/validators/input_validators.dart';
import 'package:calorify/features/auth/domain/usecases/register_user.dart';
import 'package:calorify/features/auth/presentation/pages/enter.dart';
import 'package:calorify/shared/presentation/widgets/custom_elevated_button.dart';
import 'package:calorify/shared/presentation/widgets/loading/loading_widget.dart';
import 'package:calorify/shared/presentation/widgets/shared_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///page for entering
class Register extends StatefulWidget {
  ///
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Реєстрація',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 30,),
              SharedTextField(
                hintText: "Ім'я",
                controller: _nameController,
                icon: const Icon(Icons.person_outline_rounded),
                isError: false,
              ),
              const SizedBox(height: 15,),
              SharedTextField(
                hintText: 'Email',
                controller: _emailController,
                icon: const Icon(Icons.email_outlined),
                isError: false,
                validator: InputValidators.validateEmail,
              ),
              const SizedBox(height: 15,),
              SharedTextField(
                hintText: 'Пароль',
                controller: _passwordController,
                icon: const Icon(Icons.password),
                isError: false,
                isPassword: true,
                validator: InputValidators.validatePassword,
              ),
              const SizedBox(height: 30,),
              CustomElevatedButton(
                  text: 'Далі',
                  onPressed: () async {
                    final currentState = _formKey.currentState;
                    if (currentState == null || !currentState.validate()) {
                      return;
                    }

                    // Зберігаємо дані
                    context.read<UserProvider>().setRegisterData(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    final user = context.read<UserProvider>().user;
                    final registerUser = sl<RegisterUser>();

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => Center(
                        child: Material(
                          color: Colors.transparent,
                          child: LoadingWidget(),
                        ),
                      ),
                    );

                    try {
                      await registerUser.call(user);
                      if (!mounted) return;

                      Navigator.pop(context);

                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const Enter()),
                      );
                    } catch (e) {
                      Navigator.pop(context);

                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => Center(
                          child: Material(
                            color: Colors.transparent,
                            child: LoadingWidget(),
                          ),
                        ),
                      );
                    }
                  },),
              TextButton(
                child: Text( 'Вже є акаунт? Увійти',
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
                          (context) => const Enter(),),);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
