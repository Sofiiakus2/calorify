import 'package:calorify/core/theme.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade200,
      ),
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10 , bottom: 100),
      padding: const EdgeInsets.all(40),
      child: const CircularProgressIndicator(
        strokeWidth: 5,
        strokeAlign: 0.4,
        color: primaryColor,
      ),
    );
  }
}
