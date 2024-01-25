import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';

class SeperateLine extends StatelessWidget {
  const SeperateLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.5,
      color: yellow,
      height: 0,
    );
  }
}
