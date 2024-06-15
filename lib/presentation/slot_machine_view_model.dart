import 'package:flutter/material.dart';

class SlotMachineViewModel with ChangeNotifier {
  bool _isPulled = false;

  bool get isPulled => _isPulled;

  void pullLever() {
    _isPulled = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 200), () {
      _isPulled = false;
      notifyListeners();
    });
  }
}
