import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:vampire_survivors_flame/my_game.dart';

enum _HeroAnimationState { idle, walking }

class HeroComponent extends SpriteAnimationGroupComponent<_HeroAnimationState>
    with HasGameReference<MyGame> {
  HeroComponent() : super(size: Vector2(32, 32), anchor: Anchor.center);

  late final SpriteSheet _spriteSheet;
  late final List<Sprite> _sprites;

  double speed = 100.0;

  @override
  FutureOr<void> onLoad() async {
    final image = game.images.fromCache('hero/hero_sprite.png');
    _spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 2,
      rows: 1,
    );
    _sprites = List.generate(
      _spriteSheet.rows * _spriteSheet.columns,
      _spriteSheet.getSpriteById,
    );
    animations = {
      _HeroAnimationState.idle: SpriteAnimation.spriteList(
        [_sprites[0]], // Idle animation with a single frame
        stepTime: 0.2,
      ),
      _HeroAnimationState.walking: SpriteAnimation.spriteList(
        _sprites,
        stepTime: 0.2,
      ),
    };
    current = _HeroAnimationState.idle;

    add(RectangleHitbox()..debugMode = true);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position = game.size / 2;
  }

  void move(Vector2 movement) {
    if (movement.isZero()) {
      stopMoving();
      return;
    }

    if (movement.x < 0) {
      scale.x = scale.x.abs();
    } else if (movement.x > 0) {
      scale.x = -scale.x.abs();
    }

    position.add(movement);
    current = _HeroAnimationState.walking;
  }

  void stopMoving() {
    current = _HeroAnimationState.idle;
  }
}
