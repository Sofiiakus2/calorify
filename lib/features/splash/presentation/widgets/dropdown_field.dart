import 'package:flutter/material.dart';

import 'custom_container.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const DropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 22, fontWeight: FontWeight.w800),
              decoration: const InputDecoration(border: InputBorder.none),
              dropdownColor: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
              value: selectedValue,
              items: items
                  .map((item) =>
                  DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.grey.shade400)),
        ],
      ),
    );
  }
}
