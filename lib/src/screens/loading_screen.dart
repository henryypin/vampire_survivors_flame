import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vampire_survivors_flame/my_game.dart';
import 'package:vampire_survivors_flame/src/providers/assets_manager_provider.dart';
import 'package:vampire_survivors_flame/src/providers/game_state_provider.dart';

class LoadingScreen extends PositionComponent
    with HasGameReference<MyGame>, RiverpodComponentMixin {
  ProviderSubscription<AsyncValue<AssetsManagerState>>?
  _assetsManagerSubscription;
  bool _didCompleteTransition = false;

  late final TextComponent _titleText;
  late final TextComponent _statusText;
  late final TextComponent _progressText;
  late final RectangleComponent _progressFill;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = game.size;
    position = Vector2.zero();

    add(
      RectangleComponent(
        size: game.size,
        paint: Paint()..color = const Color(0xFF000000),
      ),
    );

    _titleText = TextComponent(
      text: 'LOADING',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 28,
          color: BasicPalette.white.color,
          fontFamily: 'Perfect DOS VGA 437',
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x / 2, game.size.y * 0.42),
    );
    add(_titleText);

    _statusText = TextComponent(
      text: 'PREPARING...',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 14,
          color: const Color(0xFFD8D8D8),
          fontFamily: 'Perfect DOS VGA 437',
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x / 2, game.size.y * 0.5),
    );
    add(_statusText);

    final trackWidth = game.size.x * 0.58;
    final trackHeight = 14.0;
    final trackPosition = Vector2(game.size.x / 2, game.size.y * 0.58);

    final progressTrack = RectangleComponent(
      size: Vector2(trackWidth, trackHeight),
      position: trackPosition,
      anchor: Anchor.center,
      paint: Paint()..color = const Color(0xFF232323),
    );
    add(progressTrack);

    _progressFill = RectangleComponent(
      size: Vector2.zero(),
      position: Vector2(-trackWidth / 2, 0),
      anchor: Anchor.centerLeft,
      paint: Paint()..color = const Color(0xFFE5E5E5),
    );
    progressTrack.add(_progressFill);

    _progressText = TextComponent(
      text: '0%',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 16,
          color: BasicPalette.white.color,
          fontFamily: 'Perfect DOS VGA 437',
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x / 2, game.size.y * 0.67),
    );
    add(_progressText);
  }

  @override
  void onMount() {
    super.onMount();

    final provider = assetsManagerProvider(game);
    _assetsManagerSubscription = ref.listenManual(provider, (_, next) {
      _handleAssetsState(next);
    });
    _handleAssetsState(ref.read(provider));
  }

  @override
  void onRemove() {
    _assetsManagerSubscription?.close();
    _assetsManagerSubscription = null;
    super.onRemove();
  }

  void _handleAssetsState(AsyncValue<AssetsManagerState> asyncState) {
    if (!isMounted) {
      return;
    }

    switch (asyncState) {
      case AsyncData(:final value):
        _updateProgress(value);
        if (!value.isLoading && !_didCompleteTransition) {
          _didCompleteTransition = true;
          ref.read(gameStateProvider.notifier).setGameState(GameState.welcome);
        }
      case AsyncError():
        _statusText.text = 'LOAD FAILED';
        _progressText.text = 'ERROR';
        _progressFill.size = Vector2.zero();
      case AsyncLoading():
        _statusText.text = 'PREPARING...';
        _progressText.text = '0%';
        _progressFill.size = Vector2.zero();
    }
  }

  void _updateProgress(AssetsManagerState state) {
    final total = state.total;
    final loaded = state.loaded;
    final progress = state.progress.clamp(0.0, 1.0);
    final trackWidth = game.size.x * 0.58;

    _statusText.text = total == 0 ? 'FINALIZING...' : 'ASSETS $loaded / $total';
    _progressText.text = '${(progress * 100).round()}%';
    _progressFill.size = Vector2(trackWidth * progress, 14.0);
  }
}
