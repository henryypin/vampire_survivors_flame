import 'dart:async';
import 'dart:io';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vampire_survivors_flame/src/providers/game_state_provider.dart';
import 'package:vampire_survivors_flame/src/components/tappable_text_button.dart';
import 'package:window_manager/window_manager.dart';
import 'package:vampire_survivors_flame/my_game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';

class MainMenuScreen extends Component
    with HasGameReference<MyGame>, RiverpodComponentMixin {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    final quitButton = TappableTextButton(
      text: TextComponent(
        text: "QUIT",
        textRenderer: TextPaint(
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      backgroundColor: const Color(0xFFD32B0C),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      position: Vector2(game.size.x * 0.1, game.size.y * 0.1),
      anchor: Anchor.centerLeft,
      onPressed: () async {
        if (game.buildContext case final context?) {
          final confirmed = await _showQuitDialog(context);
          if (confirmed && isMounted) {
            await _quitApplication();
          }
        }
      },
    );

    add(quitButton);

    final optionsButton = TappableTextButton(
      text: TextComponent(
        text: "OPTIONS",
        textRenderer: TextPaint(
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      backgroundColor: const Color(0xFF2740CD),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      position: Vector2(game.size.x * 0.9, game.size.y * 0.1),
      anchor: Anchor.centerRight,
    );

    add(optionsButton);

    final startButton = TappableTextButton(
      text: TextComponent(
        text: "START",
        textRenderer: TextPaint(
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black45,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF2740CD),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      position: Vector2(game.size.x * 0.5, game.size.y * 0.65),
      onPressed: () {
        ref.read(gameStateProvider.notifier).setGameState(GameState.playing);
      },
    );

    add(startButton);

    final powerUpButton = TappableTextButton(
      text: TextComponent(
        text: "POWER UP",
        textRenderer: TextPaint(
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      backgroundColor: const Color(0xFF2E7D32),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      position: Vector2(game.size.x * 0.5, game.size.y * 0.85),
    );

    add(powerUpButton);

    final collectionButton = TappableTextButton(
      minWidth: 100,
      text: TextComponent(
        text: "COLLECTION",
        textRenderer: TextPaint(
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      backgroundColor: const Color(0xFF2740CD),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      position: Vector2(0, game.size.y * 0.85),
      anchor: Anchor.centerLeft,
    );

    add(collectionButton);

    final unlocksButton = TappableTextButton(
      minWidth: 100,
      text: TextComponent(
        text: "UNLOCKS",
        textRenderer: TextPaint(
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      backgroundColor: const Color(0xFF2740CD),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      position: Vector2(game.size.x, game.size.y * 0.85),
      anchor: Anchor.centerRight,
    );

    add(unlocksButton);
  }

  Future<bool> _showQuitDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Quit Game'),
            content: const Text('Are you sure you want to exit the game?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes, Quit'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _quitApplication() async {
    // Avoid using dart:io on web.
    if (kIsWeb) {
      // On web, typically let the user close the tab/window.
      return;
    }

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Use window_manager on desktop for consistent behavior.
      if (await windowManager.isPreventClose()) {
        await windowManager.destroy();
      } else {
        await windowManager.close();
      }
    } else {
      // Mobile and other platforms: fall back to SystemNavigator.pop.
      SystemNavigator.pop();
    }
  }
}
