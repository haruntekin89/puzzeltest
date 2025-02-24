import 'package:flutter/material.dart';

class PuntenPage extends StatelessWidget {
  const PuntenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Punten & Leaderboards')),
      body: Center(
        child: Text(
          'dit is een test nog een test!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
