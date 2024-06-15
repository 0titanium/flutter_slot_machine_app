import 'package:flutter/material.dart';

class SlotMachineViewModel with ChangeNotifier {
  bool _isPulled = false;

  bool get isPulled => _isPulled;

  void pullLever() {
    _isPulled = true;

    notifyListeners();
  }
}
