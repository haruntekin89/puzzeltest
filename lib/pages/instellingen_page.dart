import 'package:flutter/material.dart';

class InstellingenPage extends StatelessWidget {
  const InstellingenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Instellingen')),
      body: Center(
        child: Text(
          'Hier kun je accountinstellingen aanpassen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
