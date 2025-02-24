import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String tekst;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.tekst, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(tekst));
  }
}
