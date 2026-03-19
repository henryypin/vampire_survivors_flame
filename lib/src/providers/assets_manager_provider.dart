import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vampire_survivors_flame/game_assets.dart';
import 'package:vampire_survivors_flame/my_game.dart';

part 'assets_manager_provider.g.dart';

class AssetsManagerState extends Equatable {
  /// Total number of assets to load.
  final int total;

  /// Number of already loaded assets.
  final int loaded;

  /// Returns a value between 0 and 1 representing the loading progress.
  double get progress => total == 0 ? 1.0 : loaded / total;

  /// Only returns false if all the assets have been loaded, otherwise returns true.
  bool get isLoading => loaded < total;

  const AssetsManagerState({required this.total, required this.loaded});

  AssetsManagerState copyWith({int? total, int? loaded}) {
    return AssetsManagerState(
      total: total ?? this.total,
      loaded: loaded ?? this.loaded,
    );
  }

  @override
  List<Object> get props => [total, loaded];
}

@riverpod
class AssetsManagerNotifier extends _$AssetsManagerNotifier {
  bool _isDisposed = false;

  @override
  Future<AssetsManagerState> build(MyGame game) async {
    _isDisposed = false;
    ref.onDispose(() => _isDisposed = true);

    /// Assigning loadables is a very expensive operation. With this purposeful
    /// delay here, which is a bit random in duration but enough to let the UI
    /// do its job without adding too much delay for the user, we are letting
    /// the UI paint first, and then we start loading the assets.
    await Future.delayed(const Duration(seconds: 1));
    final loadables = <Future<void> Function()>[...game.preLoadAssets()];
    final initialState = AssetsManagerState(total: loadables.length, loaded: 0);

    const throttleSize = 3;
    for (var index = 0; index < throttleSize; index++) {
      unawaited(_triggerLoad(loadables, initialState));
    }

    return initialState;
  }

  Future<void> _triggerLoad(
    List<Future<void> Function()> loadables,
    AssetsManagerState initialState,
  ) async {
    if (_isDisposed || loadables.isEmpty) {
      return;
    }

    final loadable = loadables.removeAt(0);
    await loadable();

    if (_isDisposed) {
      return;
    }

    final currentState = state is AsyncData<AssetsManagerState>
        ? state.requireValue
        : initialState;
    state = AsyncData(currentState.copyWith(loaded: currentState.loaded + 1));

    await _triggerLoad(loadables, initialState);
  }
}
