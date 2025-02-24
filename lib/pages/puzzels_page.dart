import 'package:flutter/material.dart';
import 'package:puzzelapp/puzzels/lingo/lingo_screen.dart'; // Voeg deze regel toe

class PuzzelsPage extends StatelessWidget {
  // Lijst van puzzelopties
  final List<Map<String, dynamic>> puzzels = [
    {'naam': 'Lingo', 'icon': Icons.spellcheck},
    {'naam': 'Sudoku', 'icon': Icons.grid_on},
    {'naam': 'Kruiswoord', 'icon': Icons.text_fields},
    {'naam': 'Cryptogram', 'icon': Icons.lock},
    {'naam': 'Woordzoeker', 'icon': Icons.search},
    {'naam': 'Codebreker', 'icon': Icons.vpn_key},
    {'naam': 'Legcijferpuzzel', 'icon': Icons.calculate},
    {'naam': 'Cijferkruiswoord', 'icon': Icons.format_list_numbered},
    {'naam': 'Filippine', 'icon': Icons.view_module},
  ];

  PuzzelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Puzzels')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 kolommen per rij
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: puzzels.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Als het 'Lingo' is, navigeer dan naar de LingoScreen; anders naar de standaard DetailPagina.
                if (puzzels[index]['naam'] == 'Lingo') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LingoScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              DetailPagina(puzzelNaam: puzzels[index]['naam']),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(puzzels[index]['icon'], size: 50, color: Colors.blue),
                    const SizedBox(height: 10),
                    Text(
                      puzzels[index]['naam'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Detailpagina voor andere puzzels
class DetailPagina extends StatelessWidget {
  final String puzzelNaam;

  const DetailPagina({super.key, required this.puzzelNaam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(puzzelNaam)),
      body: Center(
        child: Text(
          'Hier begint het spel: $puzzelNaam',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
