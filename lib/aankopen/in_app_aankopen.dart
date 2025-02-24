import 'package:flutter/material.dart';

class InAppAankopen extends StatelessWidget {
  const InAppAankopen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('In-App Aankopen')),
      body: Center(
        child: Text(
          'Hier kun je in-app aankopen doen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
