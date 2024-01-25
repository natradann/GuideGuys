import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/constants/textfield_decoration.dart';

class TextFieldSM extends StatelessWidget {
  const TextFieldSM({
    required this.labelTFF,
    required this.hintTextinTFF,
    this.textController,
    this.inputAction,
    this.onCompletedEdit,
    this.onTextChenged,
    this.pfIcon,
    this.inputType = TextInputType.text,
    this.minLineAmount,
    this.maxLineAmount,
    this.onEditingEnd,
    this.focusNode,
    super.key,
  });

  final String labelTFF;
  final String hintTextinTFF;
  final TextEditingController? textController;
  final TextInputAction? inputAction;
  final Function()? onCompletedEdit;
  final Function(String)? onTextChenged;
  final Widget? pfIcon;
  final TextInputType inputType;
  final int? minLineAmount;
  final int? maxLineAmount;
  final Future<void> Function()? onEditingEnd;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelTFF,
          style: const TextStyle(
            color: grey700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 5),
        Focus(
          onFocusChange: (bool isFocus) async {
            if (isFocus) {
              return;
            }
            await onEditingEnd!();
          },
          child: TextFormField(
            focusNode: focusNode,
            keyboardType: inputType,
            minLines: minLineAmount,
            maxLines: maxLineAmount,
            controller: textController,
            autofocus: false,
            textInputAction: inputAction,
            decoration: InputDecoration(
              enabledBorder: yellowBorder,
              focusedBorder: yellowBorder,
              filled: true,
              fillColor: white,
              hintText: hintTextinTFF,
              prefixIcon: pfIcon,
            ),
            cursorColor: black,
            onFieldSubmitted: onTextChenged,
            onEditingComplete: onCompletedEdit,
            onTapOutside: (event) {
              if (focusNode != null) {
                focusNode!.unfocus();
              }
            },
          ),
        ),
      ],
    );
  }
}
