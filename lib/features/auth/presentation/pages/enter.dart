import 'package:calorify/core/injection_container.dart';
import 'package:calorify/core/provider/user_provide.dart';
import 'package:calorify/features/auth/domain/usecases/enter_user.dart';
import 'package:calorify/features/auth/presentation/pages/register.dart';
import 'package:calorify/features/bottom_navigation/presentation/pages/custom_bottom_navigation_view.dart';
import 'package:calorify/shared/presentation/widgets/custom_elevated_button.dart';
import 'package:calorify/shared/presentation/widgets/shared_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///page for entering
class Enter extends StatefulWidget {
  ///
  const Enter({super.key});

  @override
  State<Enter> createState() => _EnterState();
}

class _EnterState extends State<Enter> {
  final _formKey = GlobalKey<FormState>();
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
                    onPressed: () async{
                      context.read<UserProvider>().setEnterData(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      final user = context.read<UserProvider>().user;

                      final enterUser = sl<EnterUser>();
                      final String id = await enterUser.call(user);

                      await context.read<UserProvider>().loadUser(id);

                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomBottomNavigationView() ,
                        ),
                      );
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
        ),
    );
  }
}
