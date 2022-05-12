import 'package:flutter/material.dart';

class TextButtonLarge extends StatelessWidget {
  const TextButtonLarge({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final dynamic onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: TextLarge(text: text),
      onPressed: onPressed,
    );
  }
}

class TextLarge extends StatelessWidget {
  const TextLarge({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 28),
      ),
    );
  }
}
