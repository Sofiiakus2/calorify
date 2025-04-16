import 'package:flutter/material.dart';


///custom black button
class CustomElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final String text;

  ///
  const CustomElevatedButton({super.key,
    required this.text,
    required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
      ),
    );
  }
}
