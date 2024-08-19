import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slot_machine_app/const/const.dart';

class SlotMachineViewModel with ChangeNotifier {
  bool _isInit = true;
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

  List<ScrollController> controllers =
      List.generate(3, (_) => ScrollController());

  bool get isInit => _isInit;

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
    _isInit = false;
  }

  void spinWheels() async {
    int check = 0;
    if (int.parse(_gameMoney ?? '1000') < 100) {
      return;
    }

    debugPrint('-----------$check-----------');
    payForSpin();

    final random = Random();
    const baseSpinDuration = Duration(milliseconds: 3000);
    const delayBetweenStarts = Duration(milliseconds: 100);

    const itemExtent = 80.0;
    const totalItems = 28;

    List<Future> spinFutures = [];

    for (int i = 0; i < 3; i++) {
      final spinDuration = baseSpinDuration + Duration(milliseconds: 500 * i);

      // 각 휠의 스핀 시작을 지연
      await Future.delayed(delayBetweenStarts);

      spinFutures
          .add(spinWheel(i, spinDuration, itemExtent, totalItems, random));
    }

    // 모든 휠의 스핀이 완료될 때까지 기다림
    await Future.wait(spinFutures);

    // 스핀 후 매치 확인
    isMatch();
  }

  Future<void> spinWheel(
    int index,
    Duration spinDuration,
    double itemExtent,
    int totalItems,
    Random random,
  ) async {
    const minRevolutions = 5;
    final additionalRevolutions = random.nextInt(3);
    final totalSpins = (minRevolutions + additionalRevolutions) * totalItems +
        random.nextInt(totalItems);
    final totalDistance = totalSpins * itemExtent;

    final startPosition = controllers[index].position.pixels;
    final endPosition = startPosition + totalDistance;

    // 애니메이션 실행
    await controllers[index].animateTo(
      endPosition,
      duration: spinDuration,
      curve: Curves.easeInOut,
    );

    // 중앙에 정확히 멈추도록 최종 위치 조정
    final finalPosition = (endPosition / itemExtent).round() * itemExtent;
    await controllers[index].animateTo(
      finalPosition,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );

    // 릴의 심볼 업데이트
    updateReelSymbol(index, finalPosition ~/ itemExtent % symbolList.length);
  }

  void updateReelSymbol(int reelIndex, int symbolIndex) {
    switch (reelIndex) {
      case 0:
        _firstReelSymbol = symbolList[symbolIndex];
        break;
      case 1:
        _secondReelSymbol = symbolList[symbolIndex];
        break;
      case 2:
        _thirdReelSymbol = symbolList[symbolIndex];
        break;
    }

    notifyListeners();
  }

  void payForSpin() {
    _gameMoney = (int.parse(_gameMoney ?? '1000') - 100).toString();
    notifyListeners();
  }

  void isMatch() {
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
