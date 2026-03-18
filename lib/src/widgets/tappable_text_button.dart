import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:vampire_survivors_flame/src/widgets/tappable_text.dart';

class TappableTextButton extends TappableText{

  TappableTextButton({
    required super.text,
    super.minWidth = 0,
    super.minHeight = 0,
    super.onPressed,
    super.backgroundColor = const Color(0xFF2E7D32),
    super.borderColor = const Color(0xFFCEA552),
    super.borderWidth = 3.0,
    super.cornerRadius = 5.0,
    super.padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    super.position,
    super.anchor = Anchor.center,
  });

  bool isTapping = false;

  @override
  void render(Canvas canvas) {
    // print("render ${text.text}");
    super.render(canvas);
    final shadowRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(borderWidth, borderWidth, size.x - borderWidth * 2, size.y - borderWidth * 2),
      Radius.circular(cornerRadius),
    );

    final shadowPaint = Paint()
      .. color = const Color(0x80000000)
      ..style = isTapping ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawRRect(shadowRRect, shadowPaint);
  }

  @override
  bool onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    isTapping = true;
    return true;
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    isTapping = false;
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    isTapping = false;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // implement press button animation here
    if (isTapping) {
      scale = Vector2.all(0.92);
    } else {
      scale = Vector2.all(1.0);
    }
  }
}