import 'package:flutter/material.dart';

class Betaling extends StatelessWidget {
  const Betaling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Betaling')),
      body: Center(
        child: Text(
          'Hier kun je betalen voor prijzen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
