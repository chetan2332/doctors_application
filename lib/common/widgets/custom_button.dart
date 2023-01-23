import 'package:doctors_app/common/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
            disabledBackgroundColor: greenColor,
            backgroundColor: greenColor,
            minimumSize: const Size(double.infinity, 50)),
        child: Text(
          text,
          style: const TextStyle(color: backgroundColor),
        ),
      ),
    );
  }
}
