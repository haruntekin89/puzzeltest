import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shop')),
      body: Center(
        child: Text(
          'TEST!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
