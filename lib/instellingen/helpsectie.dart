import 'package:flutter/material.dart';

class Helpsectie extends StatelessWidget {
  const Helpsectie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Helpsectie')),
      body: Center(
        child: Text('Hier komt de helpsectie!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
