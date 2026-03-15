import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ad_provider.g.dart';

/// The current height of the banner ad in logical pixels.
/// 0.0 means no ad is loaded; set to actual ad height when an ad loads.
@riverpod
class AdHeight extends _$AdHeight {
  @override
  double build() => 0.0;

  void setHeight(double height) => state = height;
}
