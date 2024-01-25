import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';

class ConfirmPopup extends StatelessWidget {
  const ConfirmPopup({
    required this.onConfirm,
    required this.onCancel,
    super.key,
  });

  final Function() onConfirm;
  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: bgColor,
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        'ยืนยันข้อมูล',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text('โปรดตรวจสอบความถูกต้องของข้อมูลก่อนยืนยัน'),
      actions: [
        TextButton(
          onPressed: onCancel,
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: white,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'ยกเลิก',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: white,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'ยืนยัน',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
