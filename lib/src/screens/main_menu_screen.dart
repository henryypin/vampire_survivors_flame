import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vampire_survivors_flame/my_game.dart';
import 'package:vampire_survivors_flame/src/widgets/tappable_text_component.dart';

class MainMenuScreen extends Component with HasGameReference<MyGame>{

  late TextComponent _startButton;
  late TextComponent _settingsButton;
  late TextComponent _quitButton;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    final textStyle = TextStyle(
      fontSize: 48,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    final renderer = TextPaint(style: textStyle);

    _startButton = TappableTextComponent(
      text: 'Start new game',
      textRenderer: renderer,
      onTap: () {
        // go to game
      },
    );

    _settingsButton = TappableTextComponent(
      text: 'Setting',
      textRenderer: renderer,
      onTap: () {
        // go to setting (TBC)
      },
    );

    _quitButton = TappableTextComponent(
      text: 'Quit',
      textRenderer: renderer,
      onTap: () async {
        if (game.buildContext case final context?) {
          final confirmed = await _showQuitDialog(context);
          if (confirmed && isMounted) {
            SystemNavigator.pop(); // Exit the app
          }
        }
      },
    );

    // Position them vertically centered
    final spacing = 80.0;
    final totalHeight = spacing * 2 + 48 * 3; // approx height of texts
    final startY = (game.size.y - totalHeight) / 2;

    _startButton
      ..anchor = Anchor.center
      ..position = Vector2(game.size.x / 2, startY + 48);

    _settingsButton
      ..anchor = Anchor.center
      ..position = Vector2(game.size.x / 2, startY + 48 + spacing);

    _quitButton
      ..anchor = Anchor.center
      ..position = Vector2(game.size.x / 2, startY + 48 + spacing * 2);

    addAll([_startButton, _settingsButton, _quitButton]);

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
}
