import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class CustomNumericKeyboard extends StatelessWidget {
  final Function(String) onKeyboardTap;
  final VoidCallback? leftButtonFn;
  final VoidCallback? rightButtonFn;

  const CustomNumericKeyboard({
    required this.onKeyboardTap,
    this.leftButtonFn,
    this.rightButtonFn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumericKeyboard(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      onKeyboardTap: onKeyboardTap,
      textColor: Colors.black,
      leftButtonFn: leftButtonFn,
      leftIcon: const Icon(Icons.clear_rounded, size: 30),
      rightButtonFn: rightButtonFn,
      rightIcon: const Icon(
        Icons.arrow_circle_right_sharp,
        size: 30,
      ),
    );
  }
}
