import 'package:flutter/material.dart';

class ShopOverzicht extends StatelessWidget {
  const ShopOverzicht({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shop Overzicht')),
      body: Center(
        child: Text(
          'Hier kun je punten inwisselen voor prijzen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
