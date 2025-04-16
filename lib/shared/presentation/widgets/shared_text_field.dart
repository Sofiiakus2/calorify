import 'dart:async';
import 'package:calorify/features/food_page/presentation/bloc/food/food_block.dart';
import 'package:calorify/features/food_page/presentation/bloc/food/food_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///custom text fiels
class SharedTextField extends StatefulWidget {
  ///Constructor
  const SharedTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.isError,
    this.validator});

  final String hintText;
  final TextEditingController controller;
  final Widget? icon;
  final bool isError;
  final FormFieldValidator<String>? validator;

  @override
  State<SharedTextField> createState() => _SharedTextFieldState();
}

class _SharedTextFieldState extends State<SharedTextField> {

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: widget.controller,
      cursorColor: Colors.grey,
      style: Theme.of(context).textTheme.bodySmall,
      validator: widget.validator,
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
          borderSide: BorderSide(
            color: widget.isError ? Colors.red : Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
