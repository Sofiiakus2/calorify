import 'package:calorify/features/shared_widgets/custom_toggle.dart';
import 'package:calorify/features/shared_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';


import '../../../../../../../core/theme.dart';
import '../../../../../domain/entities/meal.dart';
import 'icon_selecting.dart';



class NewMealAlert extends StatefulWidget {
  const NewMealAlert({super.key, required this.onMealAdded});
  final Function(Meal) onMealAdded;

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
      title: Text('Створити новий прийом їжі', style: Theme.of(context).textTheme.bodyMedium,),
      content: SizedBox(
        height: 320,
        child: Column(
          children: [
            CustomTextField(
                hintText: 'Назва',
                controller: _controller,
                icon: null,
                isError: isError,
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Додати лише на сьогодні', style: Theme.of(context).textTheme.bodySmall,),
                CustomToggle(
                  onActiveChange: (value){
                    setState(() {
                      isTodayOnly = value;
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 20,),
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
          child: Text('Відмінити', style: Theme.of(context).textTheme.titleSmall,),
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

            Meal newMeal = Meal(
                meal: _controller.text,
                calories: 0,
                iconName: iconName!,
               // colorBlock: lightGreen,
                isTodayOnly: isTodayOnly
            );
            print('Added new meal: ${newMeal.meal}, icon: ${newMeal.iconName}');

            widget.onMealAdded(newMeal);
            Navigator.of(context).pop();
          },
          child: Text('Зберегти', style: Theme.of(context).textTheme.titleSmall,),
        ),
      ],
    );
  }
}
