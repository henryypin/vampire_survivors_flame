import 'dart:async';

import 'package:flame/components.dart';
import 'package:vampire_survivors_flame/my_game.dart';
import 'package:vampire_survivors_flame/src/components/floating_joystick_component.dart';
import 'package:vampire_survivors_flame/src/components/hero_component.dart';

class PlayScreen extends World with HasGameReference<MyGame> {
  late final HeroComponent _player;
  late final FloatingJoystickComponent _joystick;

  @override
  FutureOr<void> onLoad() {
    game.camera.world = this;

    _player = HeroComponent();
    _player.position = game.size / 2;
    add(_player);
    game.camera.follow(_player, snap: true);

    _joystick = FloatingJoystickComponent();
    game.camera.viewport.add(_joystick);
  }

  @override
  void onRemove() {
    if (_joystick.isMounted) {
      _joystick.removeFromParent();
    }
    game.camera.stop();
    if (game.camera.world == this) {
      game.camera.world = null;
    }
    super.onRemove();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_joystick.relativeDelta.isZero()) {
      final movement = _joystick.relativeDelta * _player.speed * dt;
      _player.move(movement);
    } else {
      _player.stopMoving();
    }
  }
}
