import 'package:flutter/material.dart';

import '../../theme.dart';

class CustomToggle extends StatefulWidget {
  const CustomToggle({super.key, required this.onActiveChange});

  final Function(bool) onActiveChange;

  @override
  State<CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isActive = !isActive;
        });

        widget.onActiveChange(isActive);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 45,
        height: 20,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: isActive ? lightGreen : appMainGrey,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),

          ),
        ),
      ),
    );
  }
}
