import 'package:flame/components.dart';
import 'package:flame/post_process.dart';

import 'package:vampire_survivors_flame/my_game.dart';
import 'package:vampire_survivors_flame/src/extensions/vector2_extension.dart';
import 'package:vampire_survivors_flame/src/post_processes/pixelation_post_process.dart';

class WelcomeScreen extends Component with HasGameReference<MyGame> {
  late SpriteComponent _background;
  late SpriteComponent _title;
  late PostProcessComponent<PixelationPostProcess> _titleEffect;

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
    final titleSize = titleSprite.srcSize.contain(game.size * 0.8);
    _title = SpriteComponent(sprite: titleSprite, size: titleSize);
    _titleEffect = PostProcessComponent(
      postProcess: PixelationPostProcess(),
      size: titleSize,
      position: Vector2((game.size.x - titleSize.x) / 2, game.size.y * 0.1),
      children: [_title],
    );
    add(_titleEffect);
  }
}
