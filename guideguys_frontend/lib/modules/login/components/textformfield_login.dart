import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';

class TextFormFieldLogIn extends StatelessWidget {
  const TextFormFieldLogIn({
    required this.labelTFF,
    this.hintTextinTFF,
    this.prefixTFF,
    //this.kbType = TextInputType.text,
    this.hideText = false,
    required this.onInputChanged,
    super.key,
  });

  final String labelTFF;
  final String? hintTextinTFF;
  final Icon? prefixTFF;
  final Function(String)? onInputChanged;
  //final TextInputType kbType;
  final bool hideText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelTFF,
          style: const TextStyle(
              color: white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: hideText,
          autofocus: false,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: yellow,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: yellow,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            filled: true,
            fillColor: white,
            hintText: hintTextinTFF,
            prefixIcon: prefixTFF,
          ),
          cursorColor: black,
          onChanged: onInputChanged,
        ),
      ],
    );
  }
}
