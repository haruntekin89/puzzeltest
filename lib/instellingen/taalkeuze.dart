import 'package:flutter/material.dart';

class Taalkeuze extends StatelessWidget {
  const Taalkeuze({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Taalkeuze')),
      body: Center(
        child: Text(
          'Hier kun je de taal kiezen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
