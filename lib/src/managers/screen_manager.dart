import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vampire_survivors_flame/src/providers/game_state_provider.dart';
import 'package:vampire_survivors_flame/src/screens/loading_screen.dart';
import 'package:vampire_survivors_flame/src/screens/main_menu_screen.dart';
import 'package:vampire_survivors_flame/src/screens/play_screen.dart';
import 'package:vampire_survivors_flame/src/screens/welcome_screen.dart';

class ScreenManager extends Component with RiverpodComponentMixin {
  Component? _currentScreen;
  ProviderSubscription<GameState>? _gameStateSubscription;

  @override
  void onMount() {
    super.onMount();
    _gameStateSubscription = ref.listenManual(gameStateProvider, (
      previous,
      next,
    ) {
      _switchToScreen(_getScreenForState(next));
    });
    // Initialize with current state
    _switchToScreen(_getScreenForState(ref.read(gameStateProvider)));
  }

  @override
  void onRemove() {
    _gameStateSubscription?.close();
    _gameStateSubscription = null;
    super.onRemove();
  }

  Component _getScreenForState(GameState state) {
    switch (state) {
      case GameState.loading:
        return LoadingScreen();
      case GameState.welcome:
        return WelcomeScreen();
      case GameState.mainMenu:
        return MainMenuScreen();
      case GameState.playing:
        return PlayScreen();
    }
  }

  void _switchToScreen(Component newScreen) {
    if (_currentScreen != null) {
      remove(_currentScreen!);
    }
    _currentScreen = newScreen;
    add(_currentScreen!);
  }
}
