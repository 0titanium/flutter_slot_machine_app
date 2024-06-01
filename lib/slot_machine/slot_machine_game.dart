import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter_slot_machine_app/slot_machine/components/machine.dart';

class SlotMachineGame extends FlameGame {
  static const double machineWidth = 136.0;
  static const double machineHeight = 104.0;
  static final Vector2 machineSize = Vector2(machineWidth, machineHeight);

  @override
  Future<void> onLoad() async {
    await Flame.images.load('slot_machine_sprite.png');

    final machine = Machine()
      ..size = machineSize
      ..position = Vector2(68.0, 100.0);

    world.add(machine);

    camera.viewfinder.visibleGameSize = Vector2(machineWidth, machineHeight);
    camera.viewfinder.position = Vector2(machineWidth, machineHeight);
    camera.viewfinder.anchor = Anchor.center;
  }

  Sprite slotMachineSprite(double x, double y, double width, double height) {
    return Sprite(
      Flame.images.fromCache('slot_machine_sprite.png'),
      srcPosition: Vector2(x, y),
      srcSize: Vector2(width, height),
    );
  }
}
