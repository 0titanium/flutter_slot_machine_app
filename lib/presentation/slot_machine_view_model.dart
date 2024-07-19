import 'package:flutter/material.dart';
import 'package:flutter_slot_machine_app/const/const.dart';

class SlotMachineViewModel with ChangeNotifier {
  String? _gameMoney;

  final String _sevenSymbol = sevenSymbolImagePath;
  final String _cherrySymbol = cherrySymbolImagePath;
  final String _bellSymbol = bellSymbolImagePath;
  final String _barSymbol = barSymbolImagePath;

  String? _firstReelSymbol;
  String? _secondReelSymbol;
  String? _thirdReelSymbol;

  final List<String> _symbolList = [
    sevenSymbolImagePath,
    cherrySymbolImagePath,
    bellSymbolImagePath,
    barSymbolImagePath,
    sevenSymbolImagePath,
    cherrySymbolImagePath,
    bellSymbolImagePath,
    barSymbolImagePath,
    sevenSymbolImagePath,
    cherrySymbolImagePath,
    bellSymbolImagePath,
    barSymbolImagePath,
    sevenSymbolImagePath,
    cherrySymbolImagePath,
    bellSymbolImagePath,
    barSymbolImagePath,
    sevenSymbolImagePath,
    cherrySymbolImagePath,
    bellSymbolImagePath,
    barSymbolImagePath,
    sevenSymbolImagePath,
    cherrySymbolImagePath,
    bellSymbolImagePath,
    barSymbolImagePath,
    sevenSymbolImagePath,
    cherrySymbolImagePath,
    bellSymbolImagePath,
    barSymbolImagePath,
  ];

  String? get gameMoney => _gameMoney;

  String get sevenSymbol => _sevenSymbol;

  String get cherrySymbol => _cherrySymbol;

  String get bellSymbol => _bellSymbol;

  String get barSymbol => _barSymbol;

  String? get firstReelSymbol => _firstReelSymbol;

  String? get secondReelSymbol => _secondReelSymbol;

  String? get thirdReelSymbol => _thirdReelSymbol;

  List<String> get symbolList => _symbolList;

  void setGameMoney() {
    _gameMoney = '1000';
  }

  void isMatch() {
    if (int.parse(_gameMoney!) < 100) {
      return;
    }

    _gameMoney = (int.parse(_gameMoney!) - 100).toString();
    notifyListeners();

    if (firstReelSymbol == sevenSymbol &&
        firstReelSymbol == secondReelSymbol &&
        firstReelSymbol == thirdReelSymbol) {
      _gameMoney = (int.parse(_gameMoney!) + 1000).toString();

      notifyListeners();
      return;
    }

    if (firstReelSymbol == secondReelSymbol ||
        secondReelSymbol == thirdReelSymbol) {
      _gameMoney = (int.parse(_gameMoney!) + 200).toString();

      notifyListeners();
      return;
    }
  }
}
