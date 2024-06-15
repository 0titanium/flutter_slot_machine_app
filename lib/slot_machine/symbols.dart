import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slot_machine_app/slot_machine/slot_machine_game.dart';

@immutable
class Symbols {
  factory Symbols.fromInt(int index) {
    assert(index >= 0 && index <= 3, 'index out');

    return _singletons[index];
  }

  final int value;
  final Sprite sprite;

  static final List<Symbols> _singletons = [
    Symbols._(0, 620, 663, 20, 80),
    Symbols._(1, 727, 663, 20, 80),
    Symbols._(2, 609, 785, 95, 95),
    Symbols._(3, 725, 775, 40, 93),
  ];

  Symbols._(this.value, double x, double y, double w, double h)
      : sprite = slotMachineSprite(x, y, w, h);
}
