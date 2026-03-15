import 'package:flame/components.dart';

import 'package:vampire_survivors_flame/my_game.dart';
import 'package:vampire_survivors_flame/src/extensions/vector2_extension.dart';

class WelcomeScreen extends Component with HasGameReference<MyGame> {
  final SpriteComponent _background = SpriteComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final bgSprite = await Sprite.load('welcome_bg.png');
    _background
      ..sprite = bgSprite
      ..size = bgSprite.srcSize.cover(game.size)
      ..position = (game.size - _background.size) / 2;
    add(_background);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _background.size = _background.size.cover(size);
    _background.position = (size - _background.size) / 2;
  }
}
