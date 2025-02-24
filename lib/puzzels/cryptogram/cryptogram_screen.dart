import 'package:flutter/material.dart';

class LingoScreen extends StatelessWidget {
  const LingoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cryptogram')),
      body: Center(
        child: Text(
          'Hier komt het Cryptogram-spel!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
