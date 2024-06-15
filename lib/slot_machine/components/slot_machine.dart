import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter_slot_machine_app/slot_machine/slot_machine_game.dart';
import 'package:flutter_slot_machine_app/slot_machine/symbols.dart';

class SlotMachine extends PositionComponent {
  SlotMachine(this.symbols) : super(size: SlotMachineGame.machineSize);

  final Symbols symbols;

  static final Paint backgroundPaint = Paint()..color = const Color(0xff380c02);

  static final RRect machineRRect = RRect.fromRectAndRadius(
    SlotMachineGame.machineSize.toRect(),
    const Radius.circular(8.0),
  );

  static final Sprite flameSprite = slotMachineSprite(1367, 6, 357, 501);

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(machineRRect, backgroundPaint);
    flameSprite.render(canvas, position: size/2, anchor: Anchor.center);
  }
}
