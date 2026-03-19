import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_state_provider.g.dart';

enum GameState { loading, welcome, mainMenu, playing }

@riverpod
class GameStateNotifier extends _$GameStateNotifier {
  @override
  GameState build() {
    return GameState.loading;
  }

  void setGameState(GameState newState) {
    state = newState;
  }
}
