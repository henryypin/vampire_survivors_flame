import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:vampire_survivors_flame/my_game.dart';
import 'package:vampire_survivors_flame/src/components/floating_joystick_component.dart';
import 'package:vampire_survivors_flame/src/components/hero_component.dart';

class PlayScreen extends World with HasGameReference<MyGame> {
  late final TiledComponent _map;
  late final HeroComponent _player;
  late final FloatingJoystickComponent _joystick;

  @override
  FutureOr<void> onLoad() async {
    game.camera.world = this;

    _map = await TiledComponent.load('map.tmx', Vector2.all(32), priority: -1);
    await add(_map);

    _player = HeroComponent();
    _player.position = _map.size / 2;
    await add(_player);
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
