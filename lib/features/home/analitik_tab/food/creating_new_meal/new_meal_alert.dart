import 'package:calorify/features/home/analitik_tab/food/creating_new_meal/custom_toggle.dart';
import 'package:calorify/features/home/analitik_tab/food/creating_new_meal/icon_selecting.dart';
import 'package:calorify/features/shared_widgets/custom_text_field.dart';
import 'package:calorify/models/eating_model.dart';
import 'package:flutter/material.dart';

import '../../../../../theme.dart';

class NewMealAlert extends StatefulWidget {
  const NewMealAlert({super.key, required this.onMealAdded});
  final Function(EatingModel) onMealAdded;

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
            if(_controller.text.isEmpty){
              setState(() {
                isError = true;
              });
            }
            EatingModel newMeal = EatingModel(
                meal: _controller.text,
                calories: 0,
                iconName: iconName!,
                colorBlock: lightGreen,
                isTodayOnly: isTodayOnly
            );

            widget.onMealAdded(newMeal);
            Navigator.of(context).pop();
          },
          child: Text('Зберегти', style: Theme.of(context).textTheme.titleSmall,),
        ),
      ],
    );
  }
}
