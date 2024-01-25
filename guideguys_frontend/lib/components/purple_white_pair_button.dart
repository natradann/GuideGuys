import 'package:flutter/material.dart';
import 'package:guideguys/components/confirm_popup.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/modules/payment/payment_view.dart';

class PurpleWhitePairButton extends StatelessWidget {
  const PurpleWhitePairButton({
    required this.whiteButtonText,
    required this.purpleButtonText,
    required this.whiteButtonFn,
    required this.purpleButtonFn,
    this.width = 150,
    this.height = 50,
    super.key,
  });

  final String whiteButtonText;
  final String purpleButtonText;
  final Function() whiteButtonFn;
  final Function() purpleButtonFn;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      TextButton(
        onPressed: whiteButtonFn,
        style: TextButton.styleFrom(
            fixedSize: Size(width, height),
            backgroundColor: white,
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
        child: Text(
          whiteButtonText,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      TextButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => ConfirmPopup(
            onCancel: () {
              Navigator.pop(context);
            },
            onConfirm: purpleButtonFn,
          ),
        ),
        style: TextButton.styleFrom(
            fixedSize: Size(width, height),
            backgroundColor: bgPurple,
            foregroundColor: white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
        child: Text(
          purpleButtonText,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ]);
  }
}
