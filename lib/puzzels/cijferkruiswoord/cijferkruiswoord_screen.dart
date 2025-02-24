import 'package:flutter/material.dart';

class LingoScreen extends StatelessWidget {
  const LingoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cijferkruiswoord')),
      body: Center(
        child: Text(
          'Hier komt het Cijferkruiswoord-spel!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
