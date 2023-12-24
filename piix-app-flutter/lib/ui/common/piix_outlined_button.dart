import 'package:flutter/material.dart';

/// Creates a custom outlined button.
class PiixOutlinedButton extends StatelessWidget {
  const PiixOutlinedButton(
      {Key? key, required this.text, this.style, required this.onPressed})
      : super(key: key);
  final String text;
  final TextStyle? style;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: Theme.of(context).outlinedButtonTheme.style,
      child: Text(text, style: style),
    );
  }
}
