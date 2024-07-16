import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slot_machine_app/const/const.dart';

class SlotMachineViewModel with ChangeNotifier {
  bool _isPulled = false;
  bool _isInit = false;

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

  final List<String> _reels = [];

  bool get isPulled => _isPulled;

  String? get gameMoney => _gameMoney;

  String get sevenSymbol => _sevenSymbol;

  String get cherrySymbol => _cherrySymbol;

  String get bellSymbol => _bellSymbol;

  String get barSymbol => _barSymbol;

  List<String> get reels => _reels;

  String? get firstReelSymbol => _firstReelSymbol;

  String? get secondReelSymbol => _secondReelSymbol;

  String? get thirdReelSymbol => _thirdReelSymbol;

  List<String> get symbolList => _symbolList;

  bool get isInit => _isInit;

  void setGameMoney() {
    _gameMoney = '1000';
  }

  void setReel() {
    int randomFirstSymbolIndex = Random().nextInt(4);
    int randomSecondSymbolIndex = Random().nextInt(4);
    int randomThirdSymbolIndex = Random().nextInt(4);

    _firstReelSymbol = _symbolList[randomFirstSymbolIndex];
    _secondReelSymbol = _symbolList[randomSecondSymbolIndex];
    _thirdReelSymbol = _symbolList[randomThirdSymbolIndex];

    if (isInit) {
      _reels.addAll([firstReelSymbol!, secondReelSymbol!, thirdReelSymbol!]);
    }

    debugPrint(reels.toString());

    _isInit = true;
  }

  void pullLever() {
    _isPulled = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 200), () {
      _isPulled = false;
      notifyListeners();
    });

    setReel();
    notifyListeners();

    isMatch();
    notifyListeners();
  }

  void isMatch() {
    if (!isInit) return;

    if (int.parse(_gameMoney!) < 100) {
      return;
    }

    _gameMoney = (int.parse(_gameMoney!) - 100).toString();
    notifyListeners();

    if (firstReelSymbol == sevenSymbol &&
        firstReelSymbol == secondReelSymbol &&
        firstReelSymbol == thirdReelSymbol) {
      _gameMoney = (int.parse(_gameMoney!) + 1000).toString();

      _reels.clear();

      notifyListeners();
      return;
    }

    if (firstReelSymbol == secondReelSymbol ||
        secondReelSymbol == thirdReelSymbol) {
      _gameMoney = (int.parse(_gameMoney!) + 200).toString();

      _reels.clear();

      notifyListeners();
      return;
    }

    _reels.clear();
  }
}
