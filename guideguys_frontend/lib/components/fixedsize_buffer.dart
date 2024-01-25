import 'package:flutter/material.dart';

class FixedSizeBuffer extends StatelessWidget {
  const FixedSizeBuffer({this.h = 10, super.key});

  final double h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: h);
  }
}