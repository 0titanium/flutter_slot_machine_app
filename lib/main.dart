import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slot_machine_app/slot_machine/slot_machine_game.dart';

void main() {
  final game = SlotMachineGame();
  runApp(GameWidget(game: game));
}
