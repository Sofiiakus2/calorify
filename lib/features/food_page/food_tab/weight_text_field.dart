import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightTextField extends StatefulWidget {
  final Function(double) onChangedWeight;
  const WeightTextField({super.key, required this.onChangedWeight});

  @override
  State<WeightTextField> createState() => _WeightTextFieldState();
}

class _WeightTextFieldState extends State<WeightTextField> {
 // Timer? _debounce;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = '100';
  }

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      cursorColor: Colors.grey,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (text) {
        if (text.isNotEmpty) {
          widget.onChangedWeight(double.tryParse(text) ?? 0.0);
        } else {
          widget.onChangedWeight(0.0);
        }
      },      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        hintText: 'грам',
        prefixIcon: Icon(Icons.add),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
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
