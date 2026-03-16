import 'package:flame/components.dart';
import 'package:flame/post_process.dart';

import 'package:vampire_survivors_flame/my_game.dart';
import 'package:vampire_survivors_flame/src/extensions/vector2_extension.dart';
import 'package:vampire_survivors_flame/src/post_processes/pixelation_post_process.dart';

class WelcomeScreen extends Component with HasGameReference<MyGame> {
  final SpriteComponent _background = SpriteComponent();
  final SpriteComponent _title = SpriteComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final bgSprite = await Sprite.load('welcome_bg.png');
    _background
      ..sprite = bgSprite
      ..size = bgSprite.srcSize.cover(game.size)
      ..position = (game.size - _background.size) / 2;
    add(_background);

    final titleSprite = await Sprite.load('welcome_title.png');
    _title
      ..sprite = titleSprite
      ..size = titleSprite.srcSize.contain(game.size * 0.8);
    final titleEffect = PostProcessComponent(
      postProcess: PixelationPostProcess(),
      position: Vector2((game.size.x - _title.size.x) / 2, game.size.y * 0.1),
      children: [_title],
    );
    add(titleEffect);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _background.size = _background.size.cover(size);
    _background.position = (size - _background.size) / 2;
    // _title.size = _title.size.contain(size * 0.8);
    // _title.position = Vector2((size.x - _title.size.x) / 2, size.y * 0.1);
  }
}
