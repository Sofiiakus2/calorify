import 'package:calorify/core/theme.dart';
import 'package:flutter/material.dart';

///Time selector dropdown
class TimeDropdown extends StatefulWidget {
  ///
  const TimeDropdown({super.key});

  @override
  _TimeDropdownState createState() => _TimeDropdownState();
}

class _TimeDropdownState extends State<TimeDropdown> {
  final List<int> intervals = [15, 20, 30, 45];
  int selectedInterval = 45;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: appMainGrey,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedInterval,
          items: intervals.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('Кожні $value хвилин', style: const TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              selectedInterval = newValue!;
            });
          },
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          dropdownColor: alertBackgroundColor,
          style: Theme.of(context).textTheme.bodySmall,
          borderRadius: BorderRadius.circular(10.0),        ),
      ),
    );
  }
}