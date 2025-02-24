import 'package:flutter/material.dart';

class PuntenOverzicht extends StatelessWidget {
  const PuntenOverzicht({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Punten Overzicht')),
      body: Center(
        child: Text(
          'Hier komt het overzicht van de punten!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
