import 'dart:math';

import 'package:calorify/core/theme.dart';
import 'package:calorify/features/home/data/models/sport_model.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/food/creating_new_meal/icon_selecting.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/sport/creating_new_sport/tooltip_icon.dart';
import 'package:calorify/features/shared_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

///Alert for adding new sport to list
class NewSportAlert extends StatefulWidget {

  const NewSportAlert({super.key, this.onSportAdded, this.editSport, this.onSportEdit, this.onSportDelete});
  final Function(SportModel)? onSportAdded;
  final SportModel? editSport;
  final Function(SportModel)? onSportEdit;
  final Function(SportModel)? onSportDelete;


  @override
  State<NewSportAlert> createState() => _NewSportAlertState();
}

class _NewSportAlertState extends State<NewSportAlert> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerCalories = TextEditingController();
  String? iconName;
  bool isErrorName = false;
  bool isErrorCalories = false;

  @override
  void initState() {
    super.initState();
    if(widget.editSport != null){
      iconName = widget.editSport?.iconName;
      _controllerName.text = widget.editSport!.name;
      _controllerCalories.text = widget.editSport!.calories.toString();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
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
            if(widget.editSport != null)
            TextButton(
              onPressed: () {
                widget.onSportDelete!(widget.editSport!);
                Navigator.of(context).pop();
              },
              child: Text('Видалити', style: Theme.of(context).textTheme.titleSmall?.copyWith(
                decoration:TextDecoration.underline,
                decorationColor: Colors.black,

              ),),
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

                if (!isErrorName && !isErrorCalories && widget.editSport != null) {
                  widget.editSport!.name = _controllerName.text;
                  widget.editSport!.calories = int.parse(_controllerCalories.text);
                  widget.editSport!.iconName = iconName!;
                 // widget.editSport!.colorBlock = getRandomLightColor();
                  widget.onSportEdit!(widget.editSport!);
                  Navigator.of(context).pop();
                }

                else if (!isErrorName && !isErrorCalories) {
                  SportModel newSport = SportModel(
                    id: Random().nextInt(1000000),
                    name: _controllerName.text,
                    calories: int.parse(_controllerCalories.text),
                    iconName: iconName!,
                    colorBlock: getRandomLightColor(),
                  );

                  widget.onSportAdded!(newSport);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Зберегти', style: Theme.of(context).textTheme.titleSmall,),
            ),
          ],
        ),
        Positioned(
            right: 30,
            top: 170,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                backgroundColor: green,
                child: Icon(Icons.close, color: Colors.black,),
              ),
            )
        ),
      ],
    );
  }
}
