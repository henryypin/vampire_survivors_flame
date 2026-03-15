// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The current height of the banner ad in logical pixels.
/// 0.0 means no ad is loaded; set to actual ad height when an ad loads.

@ProviderFor(AdHeight)
final adHeightProvider = AdHeightProvider._();

/// The current height of the banner ad in logical pixels.
/// 0.0 means no ad is loaded; set to actual ad height when an ad loads.
final class AdHeightProvider extends $NotifierProvider<AdHeight, double> {
  /// The current height of the banner ad in logical pixels.
  /// 0.0 means no ad is loaded; set to actual ad height when an ad loads.
  AdHeightProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adHeightProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adHeightHash();

  @$internal
  @override
  AdHeight create() => AdHeight();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$adHeightHash() => r'b1c1516a28c84fc78f54ca27a78ce593b20a2f76';

/// The current height of the banner ad in logical pixels.
/// 0.0 means no ad is loaded; set to actual ad height when an ad loads.

abstract class _$AdHeight extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
