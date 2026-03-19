import 'package:flame/extensions.dart';
import 'package:vampire_survivors_flame/my_game.dart';

extension GameAssetsX on MyGame {
  List<Future<Image> Function()> preLoadAssets() {
    return [
      () => images.load('welcome_bg.png'),
      () => images.load('welcome_title.png'),
      () => images.load('hero/hero_sprite.png'),
    ];
  }
}
