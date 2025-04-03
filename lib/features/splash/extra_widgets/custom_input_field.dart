import 'package:calorify/features/splash/extra_widgets/custom_container.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const InputField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 22, fontWeight: FontWeight.w800),
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          Text(label, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey.shade400)),
        ],
      ),
    );
  }
}
