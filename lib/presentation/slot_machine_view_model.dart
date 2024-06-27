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

  bool get isInit => _isInit;

  void setGameMoney() {
    _gameMoney = '1000';
    
    _isInit = true;
  }

  void setReel() {
    int randomFirstSymbolIndex = Random().nextInt(4);
    int randomSecondSymbolIndex = Random().nextInt(4);
    int randomThirdSymbolIndex = Random().nextInt(4);

    _firstReelSymbol = _symbolList[randomFirstSymbolIndex];
    _secondReelSymbol = _symbolList[randomSecondSymbolIndex];
    _thirdReelSymbol = _symbolList[randomThirdSymbolIndex];

    _isInit = true;
  }

  void pullLever() {
    _isPulled = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 200), () {
      _isPulled = false;
      notifyListeners();
    });
  }
}
