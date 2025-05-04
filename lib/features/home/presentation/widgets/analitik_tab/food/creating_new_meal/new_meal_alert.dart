import 'package:calorify/core/theme.dart';
import 'package:calorify/features/home/domain/entities/meal.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/food/creating_new_meal/icon_selecting.dart';
import 'package:calorify/shared/presentation/widgets/custom_toggle.dart';
import 'package:calorify/shared/presentation/widgets/shared_text_field.dart';
import 'package:flutter/material.dart';


///alert for creating new meal
class NewMealAlert extends StatefulWidget {
  final Function(Meal) onMealAdded;

  ///
  const NewMealAlert({required this.onMealAdded, super.key});

  @override
  State<NewMealAlert> createState() => _NewMealAlertState();
}

class _NewMealAlertState extends State<NewMealAlert> {
  final TextEditingController _controller = TextEditingController();
  bool isTodayOnly = false;
  String? iconName;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: alertBackgroundColor,
      title: Text('Створити новий прийом їжі',
        style: Theme.of(context).textTheme.bodyMedium,),
      content: SizedBox(
        height: 320,
        child: Column(
          children: [
            SharedTextField(
                hintText: 'Назва',
                controller: _controller,
                icon: null,
                isError: isError,
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Додати лише на сьогодні',
                  style: Theme.of(context).textTheme.bodySmall,),
                CustomToggle(
                  onActiveChange: (value){
                    setState(() {
                      isTodayOnly = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20,),
            IconSelecting(
              iconPathPrefix: 'food',
              onIconChoose: (value){
                setState(() {
                  iconName = value;
                });
              },
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Відмінити',
            style: Theme.of(context).textTheme.titleSmall,),
        ),
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
            if (_controller.text.isEmpty || iconName == null) {
              setState(() {
                isError = _controller.text.isEmpty;
              });
              return;
            }

            final Meal newMeal = Meal(
                meal: MealType.custom,
                calories: 0,
                iconName: iconName!,
                isTodayOnly: isTodayOnly,
                products: [],
            );
           // print('Added new meal: ${newMeal.meal}, icon: ${newMeal.iconName}');

            widget.onMealAdded(newMeal);
            Navigator.of(context).pop();
          },
          child: Text('Зберегти', style: Theme.of(context).textTheme.titleSmall,),
        ),
      ],
    );
  }
}

