// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_manager_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssetsManagerNotifier)
final assetsManagerProvider = AssetsManagerNotifierFamily._();

final class AssetsManagerNotifierProvider
    extends $AsyncNotifierProvider<AssetsManagerNotifier, AssetsManagerState> {
  AssetsManagerNotifierProvider._({
    required AssetsManagerNotifierFamily super.from,
    required MyGame super.argument,
  }) : super(
         retry: null,
         name: r'assetsManagerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$assetsManagerNotifierHash();

  @override
  String toString() {
    return r'assetsManagerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AssetsManagerNotifier create() => AssetsManagerNotifier();

  @override
  bool operator ==(Object other) {
    return other is AssetsManagerNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$assetsManagerNotifierHash() =>
    r'98aaf0324651ad99008bba10f57006139ec46ecc';

final class AssetsManagerNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          AssetsManagerNotifier,
          AsyncValue<AssetsManagerState>,
          AssetsManagerState,
          FutureOr<AssetsManagerState>,
          MyGame
        > {
  AssetsManagerNotifierFamily._()
    : super(
        retry: null,
        name: r'assetsManagerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AssetsManagerNotifierProvider call(MyGame game) =>
      AssetsManagerNotifierProvider._(argument: game, from: this);

  @override
  String toString() => r'assetsManagerProvider';
}

abstract class _$AssetsManagerNotifier
    extends $AsyncNotifier<AssetsManagerState> {
  late final _$args = ref.$arg as MyGame;
  MyGame get game => _$args;

  FutureOr<AssetsManagerState> build(MyGame game);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AssetsManagerState>, AssetsManagerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AssetsManagerState>, AssetsManagerState>,
              AsyncValue<AssetsManagerState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
