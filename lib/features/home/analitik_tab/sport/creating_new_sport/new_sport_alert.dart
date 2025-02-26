import 'package:calorify/features/shared_widgets/custom_toggle.dart';
import 'package:calorify/features/home/analitik_tab/food/creating_new_meal/icon_selecting.dart';
import 'package:calorify/features/home/analitik_tab/sport/creating_new_sport/tooltip_icon.dart';
import 'package:calorify/features/shared_widgets/custom_text_field.dart';
import 'package:calorify/models/eating_model.dart';
import 'package:flutter/material.dart';

import '../../../../../models/sport_model.dart';
import '../../../../../theme.dart';

class NewSportAlert extends StatefulWidget {
  const NewSportAlert({super.key, required this.onSportAdded});
  final Function(SportModel) onSportAdded;

  @override
  State<NewSportAlert> createState() => _NewSportAlertState();
}

class _NewSportAlertState extends State<NewSportAlert> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerCalories = TextEditingController();
  bool isTodayOnly = false;
  String? iconName;
  bool isErrorName = false;
  bool isErrorCalories = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: alertBackgroundColor,
      title: Text('Створити нову активність', style: Theme.of(context).textTheme.bodyMedium,),
      content: SizedBox(
        height: 350,
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Назва',
              controller: _controllerName,
              icon: null,
              isError: isErrorName,
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Кількість ккал',
                    controller: _controllerCalories,
                    icon: null,
                    isError: isErrorCalories,
                  ),
                ),
                const SizedBox(width: 5),
                TooltipIcon()
              ],
            ),
            SizedBox(height: 20,),
            IconSelecting(
              iconPathPrefix: 'sport',
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
            setState(() {
              isErrorName = _controllerName.text.isEmpty;

              isErrorCalories = !_controllerCalories.text.isNotEmpty ||
                  !RegExp(r'^\d+$').hasMatch(_controllerCalories.text);
            });

            if (!isErrorName && !isErrorCalories) {
              SportModel newSport = SportModel(
                name: _controllerName.text,
                calories: int.parse(_controllerCalories.text),
                iconName: iconName!,
                colorBlock: getRandomLightColor(),
              );

              widget.onSportAdded(newSport);
              Navigator.of(context).pop();
            }
          },
          child: Text('Зберегти', style: Theme.of(context).textTheme.titleSmall,),
        ),
      ],
    );
  }
}
