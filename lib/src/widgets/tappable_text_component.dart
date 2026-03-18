import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'dart:async';

class TappableTextComponent extends TextComponent with TapCallbacks {

  final FutureOr<void> Function()? onTap;

  TappableTextComponent({
    this.onTap,
    super.text,
    super.textRenderer,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
    super.key,
  });

  @override
  void onTapDown(TapDownEvent event) {
    print("Tapped on $text !");
    onTap?.call();
  }
}