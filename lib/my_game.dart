import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:vampire_survivors_flame/src/managers/screen_manager.dart';

class MyGame extends FlameGame with RiverpodGameMixin {
  MyGame() : super(camera: CameraComponent(viewport: MaxViewport()));

  @override
  Color backgroundColor() => const Color(0xFF000000);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(ScreenManager());
  }
}
