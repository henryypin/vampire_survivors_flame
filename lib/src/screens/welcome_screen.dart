import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flame/post_process.dart';
import 'package:flame/text.dart';
import 'package:vampire_survivors_flame/my_game.dart';
import 'package:vampire_survivors_flame/src/effects/blink_text_effect.dart';
import 'package:vampire_survivors_flame/src/extensions/vector2_extension.dart';
import 'package:vampire_survivors_flame/src/post_processes/pixelation_post_process.dart';

class WelcomeScreen extends Component with HasGameReference<MyGame> {
  late SpriteComponent _background;
  late SpriteComponent _title;
  late PixelationPostProcess _titlePixelationEffect;
  late PostProcessComponent<PixelationPostProcess> _titleEffect;
  late TextComponent _pressToStart;

  static const double _entranceAnimationDuration = 1.5;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final bgSprite = await Sprite.load('welcome_bg.png');
    _background = SpriteComponent(
      sprite: bgSprite,
      size: bgSprite.srcSize.cover(game.size),
    );
    _background.position = (game.size - _background.size) / 2;
    add(_background);

    final titleSprite = await Sprite.load('welcome_title.png');
    final titleSize = titleSprite.srcSize.contain(game.size * 0.65);
    _title = SpriteComponent(sprite: titleSprite, size: titleSize);
    _titlePixelationEffect = PixelationPostProcess();
    _titleEffect = PostProcessComponent(
      postProcess: _titlePixelationEffect,
      size: titleSize,
      position: Vector2((game.size.x - titleSize.x) / 2, game.size.y * 0.15),
      children: [_title],
    );
    add(_titleEffect);

    _pressToStart = TextComponent(
      text: 'PRESS TO START',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 20.0,
          color: BasicPalette.white.color,
          fontFamily: 'Perfect DOS VGA 437',
        ),
      ),
    );
    _pressToStart.position = Vector2(
      (game.size.x - _pressToStart.size.x) / 2,
      game.size.y * 0.6,
    );
    _pressToStart.add(
      BlinkTextEffect(EffectController(duration: 1.0, infinite: true)),
    );
  }

  @override
  void onMount() {
    super.onMount();
    add(
      TimerComponent(
        period: _entranceAnimationDuration,
        repeat: false,
        removeOnFinish: true,
        onTick: () {
          _titlePixelationEffect.setEnabled(false);
        },
      ),
    );
    add(
      TimerComponent(
        period: _entranceAnimationDuration,
        repeat: false,
        removeOnFinish: true,
        onTick: () {
          add(_pressToStart);
        },
      ),
    );
  }
}
