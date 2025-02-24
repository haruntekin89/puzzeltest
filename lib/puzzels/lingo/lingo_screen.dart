import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Zorgt dat KeyEvent, KeyDownEvent en LogicalKeyboardKey beschikbaar zijn
import 'package:intl/intl.dart';
import 'package:puzzelapp/puzzels/lingo/lingo_manager.dart';

class LingoScreen extends StatefulWidget {
  const LingoScreen({super.key});

  @override
  createState() => _LingoScreenState();
}

class _LingoScreenState extends State<LingoScreen> {
  final LingoManager _lingoManager =
      LingoManager(); // Instantie van LingoManager

  List<String> woordenlijst = [];
  String teRadenWoord = '';
  int poging = 0;
  int score = 0;
  int gebruikteHints = 0;
  bool isGeraden = false;
  bool alGewonnen = false;
  bool plezierModus = false;

  // Grid: tekst controllers, focus nodes en kleuren voor 5x5
  List<List<TextEditingController>> gridControllers = List.generate(
    5,
    (_) => List.generate(5, (_) => TextEditingController()),
  );

  List<List<FocusNode>> focusNodes = List.generate(
    5,
    (_) => List.generate(5, (_) => FocusNode()),
  );

  List<List<Color>> gridKleuren = List.generate(
    5,
    (_) => List.filled(5, Colors.white),
  );

  List<String> pogingen = [];

  @override
  void initState() {
    super.initState();
    _initialiseerSpel();
  }

  /// Initialisatie met dagelijkse resetcontrole en reset van de spelstatus
  Future<void> _initialiseerSpel() async {
    // Reset de spelvariabelen
    poging = 0;
    isGeraden = false;
    gebruikteHints = 0;
    pogingen.clear();
    gridKleuren = List.generate(5, (_) => List.filled(5, Colors.white));
    // Maak alle tekstvelden leeg
    for (var rij in gridControllers) {
      for (var controller in rij) {
        controller.clear();
      }
    }

    await _laadWoordenlijst();
    await _controleerDagelijkseReset();
    await _laadScore();
    if (mounted) setState(() {});
  }

  /// Controleer of het een nieuwe dag is voor een dagelijkse reset
  Future<void> _controleerDagelijkseReset() async {
    String vandaag = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String laatsteDatum = await _lingoManager.getLastWinDate();

    if (vandaag != laatsteDatum) {
      await _lingoManager.resetDag();
      teRadenWoord = (woordenlijst..shuffle()).first;
      await _lingoManager.setLastWinDate(vandaag);
      alGewonnen = false;
      plezierModus = false;
    } else {
      alGewonnen = await _lingoManager.hasWonToday();
      if (!alGewonnen) {
        teRadenWoord = (woordenlijst..shuffle()).first;
      } else {
        teRadenWoord = (woordenlijst..shuffle()).first;
        plezierModus = true;
        _toonMelding('Je hebt vandaag al gewonnen! Speel nu voor plezier.');
      }
    }
  }

  Future<void> _laadScore() async {
    int opgeslagenScore = await _lingoManager.getScore();
    if (mounted) {
      setState(() {
        score = opgeslagenScore;
      });
    }
  }

  Future<void> _laadWoordenlijst() async {
    try {
      final String woordenCSV = await rootBundle.loadString(
        'lib/assets/woordenlijst.csv',
      );
      woordenlijst =
          woordenCSV
              .split('\n')
              .map((woord) => woord.trim().toLowerCase())
              .toList();
    } catch (e) {
      debugPrint("Fout bij het inladen van de woordenlijst: $e");
    }
  }

  /// Controleer het ingevulde woord en animeer de kleurverandering per letter
  Future<void> _controleerWoord() async {
    if (teRadenWoord.isEmpty || teRadenWoord == '*****') {
      _toonMelding('Geen geldig woord om te raden.');
      return;
    }

    String invoer = '';
    for (int i = 0; i < 5; i++) {
      invoer += gridControllers[poging][i].text.toLowerCase();
    }

    if (invoer.length == 5) {
      pogingen.add(invoer);
      List<Color> kleurResultaat = List.filled(5, Colors.red);
      List<String> tempLetters = teRadenWoord.split('');
      List<bool> juistePosities = List.filled(5, false);

      // Eerst: groene letters (juiste letter op de juiste positie)
      for (int i = 0; i < 5; i++) {
        if (invoer[i] == teRadenWoord[i]) {
          kleurResultaat[i] = Colors.green;
          juistePosities[i] = true;
          tempLetters[i] = '';
        }
      }

      // Daarna: gele letters (juiste letter, maar op verkeerde positie)
      for (int i = 0; i < 5; i++) {
        if (!juistePosities[i] && tempLetters.contains(invoer[i])) {
          kleurResultaat[i] = Colors.yellow;
          tempLetters[tempLetters.indexOf(invoer[i])] = '';
        }
      }

      // Animeer de kleurverandering per letter
      for (int i = 0; i < 5; i++) {
        await Future.delayed(const Duration(milliseconds: 300));
        if (mounted) {
          setState(() {
            gridKleuren[poging][i] = kleurResultaat[i];
          });
        }
      }

      if (invoer == teRadenWoord) {
        isGeraden = true;
        await _handleWin();
      }

      if (mounted) {
        setState(() {
          poging++;
          if (poging == 5 && !isGeraden) {
            _toonMelding('Het juiste woord was: $teRadenWoord');
          }
        });
      }
    }
  }

  /// Verwerkt de overwinning: update de score en toont een pop-up met vuurwerk-animatie
  Future<void> _handleWin() async {
    if (!alGewonnen) {
      score += 10;
      await _lingoManager.saveScore(score);
      await _lingoManager.setWonToday();
      alGewonnen = true;
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Stack(
              alignment: Alignment.center,
              children: [
                // Vervang de onderstaande Container eventueel door een Lottie-animatie
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Gefeliciteerd!\nJe hebt het goed geraden!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      if (!mounted) return;
      _toonMelding('Je hebt vandaag al gewonnen! Speel nu voor plezier.');
      plezierModus = true;
    }
  }

  /// Functie om een hint te gebruiken (max 3 hints per woord)
  void _gebruikHint() {
    if (gebruikteHints < 3 && !isGeraden) {
      for (int i = 0; i < 5; i++) {
        if (gridControllers[poging][i].text.isEmpty) {
          gridControllers[poging][i].text = teRadenWoord[i];
          gridKleuren[poging][i] = Colors.green;
          gebruikteHints++;
          _toonMelding('Hint gebruikt! ($gebruikteHints/3)');
          setState(() {});
          return;
        }
      }
    } else {
      _toonMelding('Geen hints meer beschikbaar.');
    }
  }

  void _toonMelding(String bericht) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(bericht), duration: const Duration(seconds: 3)),
      );
    }
  }

  /// Handler voor backspace: wist de huidige letter en verplaatst de focus
  void _handleBackspace(int rij, int kolom) {
    if (gridControllers[rij][kolom].text.isEmpty && kolom > 0) {
      FocusScope.of(context).requestFocus(focusNodes[rij][kolom - 1]);
      gridControllers[rij][kolom - 1].clear();
    } else {
      gridControllers[rij][kolom].clear();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lingo - Score: $score - Hints: $gebruikteHints/3'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 25,
              itemBuilder: (context, index) {
                final rij = index ~/ 5;
                final kolom = index % 5;
                return Container(
                  decoration: BoxDecoration(
                    color: gridKleuren[rij][kolom],
                    shape: BoxShape.circle,
                  ),
                  // Gebruik de Focus-widget met onKeyEvent (i.p.v. onKey)
                  child: Focus(
                    focusNode: focusNodes[rij][kolom],
                    onKeyEvent: (node, event) {
                      if (event is KeyDownEvent &&
                          event.logicalKey == LogicalKeyboardKey.backspace) {
                        _handleBackspace(rij, kolom);
                        return KeyEventResult.handled;
                      }
                      return KeyEventResult.ignored;
                    },
                    child: TextField(
                      controller: gridControllers[rij][kolom],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onChanged: (waarde) {
                        // Als er een letter wordt ingevuld
                        if (waarde.length == 1) {
                          // Nog niet bij de laatste letter? Ga door
                          if (kolom < 4) {
                            FocusScope.of(
                              context,
                            ).requestFocus(focusNodes[rij][kolom + 1]);
                          } else {
                            // Laatste cel -> controleer woord
                            FocusScope.of(context).unfocus();
                            _controleerWoord();
                          }
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _gebruikHint,
            child: const Text('Gebruik Hint'),
          ),
          ElevatedButton(
            onPressed: _initialiseerSpel,
            child: const Text('Nieuw Spel'),
          ),
        ],
      ),
    );
  }
}
