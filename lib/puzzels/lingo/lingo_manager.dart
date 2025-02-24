import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LingoManager {
  List<String> woordenlijst = [];
  String teRadenWoord = '';
  int poging = 0;
  int score = 0;
  bool isGeraden = false;
  bool alGewonnen = false;

  // Grid: kleuren voor 5 pogingen (rijen) met 5 letters per poging.
  List<List<Color>> gridKleuren = List.generate(
    5,
    (_) => List.filled(5, Colors.white),
  );

  /// Initialiseer het spel: reset variabelen, laad woordenlijst, kies woord en reset score.
  Future<void> initialiseerSpel() async {
    poging = 0;
    isGeraden = false;
    alGewonnen = false;
    gridKleuren = List.generate(5, (_) => List.filled(5, Colors.white));

    await _laadWoordenlijst();
    await _laadDagelijkseWoord();
    _laadScore();

    debugPrint("=== DEBUG: initialiseerSpel() ===");
    debugPrint("Te raden woord voor vandaag: $teRadenWoord");
    debugPrint("Score bij start: $score");
  }

  /// Laadt de score in (dummy-implementatie: score wordt hier gereset naar 0)
  void _laadScore() {
    score = 0;
  }

  /// Laadt de woordenlijst uit een CSV-bestand in de assets
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
      debugPrint("=== DEBUG: _laadWoordenlijst() ===");
      debugPrint("Aantal woorden geladen: ${woordenlijst.length}");
    } catch (e) {
      debugPrint("Fout bij het inladen van de woordenlijst: $e");
    }
  }

  /// Selecteert het te raden woord. Hier simuleren we dat er nog niet gewonnen is.
  Future<void> _laadDagelijkseWoord() async {
    // In deze dummy-versie gaan we er altijd van uit dat er nog niet gewonnen is.
    alGewonnen = false;
    teRadenWoord = (woordenlijst..shuffle()).first;
    debugPrint("=== DEBUG: _laadDagelijkseWoord() ===");
    debugPrint("Te raden woord: $teRadenWoord");
    debugPrint("Al gewonnen vandaag: $alGewonnen");
  }

  /// Controleert het ingevoerde woord en geeft een lijst met kleuren terug.
  /// Groen = juiste letter op de juiste positie,
  /// Geel = juiste letter, maar op de verkeerde positie,
  /// Rood = fout.
  List<Color> controleerWoord(String invoer) {
    List<Color> kleurResultaat = List.filled(5, const Color(0xFFFF0000));
    List<String?> tempLetters = teRadenWoord.split('');
    List<bool> juistePosities = List.filled(5, false);
    List<bool> gebruikt = List.filled(5, false);

    debugPrint("=== DEBUG: controleerWoord() aangeroepen ===");
    debugPrint("Ingevuld: $invoer");
    debugPrint("Te raden woord: $teRadenWoord");

    // Stap 1: Check voor groene letters (juiste letter op de juiste positie)
    for (int i = 0; i < 5; i++) {
      if (invoer[i] == teRadenWoord[i]) {
        kleurResultaat[i] = const Color(0xFF4CAF50); // Groen
        juistePosities[i] = true;
        gebruikt[i] = true;
        tempLetters[i] = null;
      }
    }

    debugPrint("=== DEBUG: Na groene check ===");
    debugPrint("TempLetters: $tempLetters");
    debugPrint("JuistePosities: $juistePosities");
    debugPrint("Gebruikt: $gebruikt");
    debugPrint("KleurResultaat: $kleurResultaat");

    // Stap 2: Check voor gele letters (juiste letter, maar op verkeerde positie)
    for (int i = 0; i < 5; i++) {
      if (!juistePosities[i]) {
        for (int j = 0; j < 5; j++) {
          if (invoer[i] == teRadenWoord[j] &&
              !gebruikt[j] &&
              !juistePosities[j]) {
            kleurResultaat[i] = const Color(0xFFFFEB3B); // Geel
            gebruikt[j] = true;
            break;
          }
        }
      }
    }

    debugPrint("=== DEBUG: Na gele check ===");
    debugPrint("KleurResultaat: $kleurResultaat");

    // Win-check: als het ingevoerde woord overeenkomt met het te raden woord
    if (invoer == teRadenWoord) {
      isGeraden = true;
      _handleWin();
    }

    poging++;
    debugPrint("=== DEBUG: Terug te geven kleurResultaat ===");
    debugPrint("KleurResultaat: $kleurResultaat");

    return kleurResultaat;
  }

  /// Verwerkt de overwinning: verhoogt de score met 10 punten.
  Future<void> _handleWin() async {
    debugPrint("=== DEBUG: _handleWin() ===");
    debugPrint("Huidige score: $score - 10 punten toevoegen");
    if (!alGewonnen) {
      score += 10;
      alGewonnen = true;
    }
  }

  /// Geeft het te raden woord terug (handig voor meldingen)
  String getJuisteWoord() {
    debugPrint("=== DEBUG: getJuisteWoord() ===");
    debugPrint("Het juiste woord was: $teRadenWoord");
    return teRadenWoord;
  }

  // -----------------------
  // Extra methodes voor dagelijkse reset en scorebeheer
  // Dummy implementaties met in-memory opslag

  static String _lastWinDate = "";
  static bool _hasWonToday = false;
  static int _savedScore = 0;

  Future<String> getLastWinDate() async {
    // Retourneer de laatst opgeslagen datum (dummy implementatie)
    return _lastWinDate;
  }

  Future<void> resetDag() async {
    // Reset de dagelijkse status (dummy implementatie)
    _hasWonToday = false;
  }

  Future<void> setLastWinDate(String date) async {
    _lastWinDate = date;
  }

  Future<bool> hasWonToday() async {
    return _hasWonToday;
  }

  Future<int> getScore() async {
    return _savedScore;
  }

  Future<void> saveScore(int score) async {
    _savedScore = score;
  }

  Future<void> setWonToday() async {
    _hasWonToday = true;
  }
}
