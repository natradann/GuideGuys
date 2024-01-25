import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';

class PurpleButton extends StatelessWidget {
  const PurpleButton({
    required this.buttonText,
    required this.onTapped,
    this.pfIcon,
    super.key,
  });

  final String buttonText;
  final Function() onTapped;
  final Icon? pfIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTapped,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgPurple,
        foregroundColor: white,
        //fixedSize: const Size(90, 50),
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      icon: const Icon(Icons.chat_bubble_outline_rounded),
      label: Text(
        buttonText,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
