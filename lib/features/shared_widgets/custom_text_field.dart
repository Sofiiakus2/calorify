import 'package:flutter/material.dart';

import '../../theme.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.hintText, required this.controller, required this.icon, required this.isError});

  final String hintText;
  final TextEditingController controller;
  final Widget? icon;
  final bool isError;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: Colors.grey,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.icon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide:  BorderSide(color: widget.isError
              ? Colors.red
              : Colors.grey,
              width: 1.0),        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide(
              color:  Colors.black,
              width: 1.0),
        ),
      ),

    );
  }
}
