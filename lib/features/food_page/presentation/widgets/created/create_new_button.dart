import 'package:calorify/features/food_page/presentation/widgets/created/create_new_own_product_alert.dart';
import 'package:calorify/features/food_page/presentation/widgets/created/food_facts_password_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNewButton extends StatelessWidget {
  const CreateNewButton({super.key});

  Future<bool> _hasSavedOffUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('off_user_id');
    final password = prefs.getString('off_user_password');

    return userId != null && password != null;
  }

  void _handleTap(BuildContext context) async {
    final hasUser = await _hasSavedOffUser();
    print(hasUser);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (hasUser) {
          return const CreateNewOwnProductAlert();
        } else {
          return FoodFactsPasswordAlert(
            onPasswordEntered: () {
              Navigator.of(context).pop();
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: Colors.grey.shade200,
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.add, color: Colors.black,),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Створити власний продукт',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
