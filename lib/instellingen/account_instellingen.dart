import 'package:flutter/material.dart';

class AccountInstellingen extends StatelessWidget {
  const AccountInstellingen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Instellingen')),
      body: Center(
        child: Text(
          'Hier kun je je accountinstellingen aanpassen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
