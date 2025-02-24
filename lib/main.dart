import 'package:flutter/material.dart';
import 'package:puzzelapp/pages/puzzels_page.dart';
import 'package:puzzelapp/pages/punten_page.dart';
import 'package:puzzelapp/pages/shop_page.dart';
import 'package:puzzelapp/pages/instellingen_page.dart';

void main() {
  runApp(const PuzzelApp());
}

class PuzzelApp extends StatelessWidget {
  const PuzzelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puzzel App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Markeer de lijst als final, omdat deze na initialisatie niet verandert.
  static final List<Widget> _pages = <Widget>[
    PuzzelsPage(),
    PuntenPage(),
    ShopPage(),
    InstellingenPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Puzzel App')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.extension),
            label: 'Puzzels',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Punten'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Instellingen',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
