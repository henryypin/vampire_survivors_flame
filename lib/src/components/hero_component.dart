import 'dart:async';

import 'package:flame/components.dart';
import 'package:vampire_survivors_flame/my_game.dart';

class HeroComponent extends SpriteComponent with HasGameReference<MyGame> {
  HeroComponent() : super(size: Vector2(32, 32), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('hero/hero_sprite.png');
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position = game.size / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
