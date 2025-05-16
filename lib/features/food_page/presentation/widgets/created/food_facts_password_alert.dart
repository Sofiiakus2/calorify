
import 'package:calorify/core/injection_container.dart';
import 'package:calorify/core/theme.dart';
import 'package:calorify/features/food_page/domain/usecases/created_products/register_user_to_food_facts.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/sport/creating_new_sport/tooltip_icon.dart';
import 'package:calorify/shared/presentation/widgets/shared_text_field.dart';
import 'package:flutter/material.dart';

///Alert for adding new sport to list
class FoodFactsPasswordAlert extends StatefulWidget {

  ///
  const FoodFactsPasswordAlert({
    super.key,
    this.onPasswordEntered,
  });

  final Function()? onPasswordEntered;


  @override
  State<FoodFactsPasswordAlert> createState() => _FoodFactsPasswordAlertState();
}

class _FoodFactsPasswordAlertState extends State<FoodFactsPasswordAlert> {
  final TextEditingController _controllerPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          backgroundColor: alertBackgroundColor,
          title: Text('Новий пароль для створення продуктів', style: Theme.of(context).textTheme.bodyMedium,),
          content: SizedBox(
            height: 70,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SharedTextField(
                        hintText: 'Пароль',
                        controller: _controllerPassword,
                        icon: null,
                        isError: false,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const TooltipIcon(text: 'Пароль який буде використовуватись для створення нових продуктів. Рекомендуємо щоб він відрізнявся від основного паролю',)
                  ],
                ),
              ],
            ),
          ),
          actions: [

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appMainGrey,
                side: const BorderSide(color: Colors.black, width: 1),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                final register = sl<RegisterUserToFoodFacts>();
                register.registerUserToFoodFacts(_controllerPassword.text);
                Navigator.pop(context);
              },
              child: Text('Зберегти', style: Theme.of(context).textTheme.titleSmall,),
            ),
          ],
        ),
        Positioned(
          right: 30,
          top: 270,
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              backgroundColor: green,
              child: Icon(Icons.close, color: Colors.black,),
            ),
          ),
        ),
      ],
    );
  }
}
