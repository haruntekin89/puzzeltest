import 'package:flutter/material.dart';

class Leaderboards extends StatelessWidget {
  const Leaderboards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leaderboards')),
      body: Center(
        child: Text(
          'Hier komen de leaderboards!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
