import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class TappableText extends PositionComponent with TapCallbacks {
  final TextComponent text;
  final double minWidth;
  final double minHeight;
  final FutureOr<void> Function()? onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double cornerRadius;
  final EdgeInsets padding;

  TappableText({
    required this.text,
    this.minWidth = 0,
    this.minHeight = 0,
    this.onPressed,
    this.backgroundColor = const Color(0xFF2E7D32),
    this.borderColor = const Color(0xFFCEA552),
    this.borderWidth = 3.0,
    this.cornerRadius = 5.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    super.position,
    super.anchor = Anchor.center,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Calculate size based on text + padding + borderWidth
    final textSize = text.size;
    final width = max(minWidth, textSize.x + padding.horizontal + borderWidth * 2);
    final height = max(minHeight, textSize.y + padding.vertical + borderWidth * 2);
    size = Vector2(width, height);

    // default position is top-right
    // add padding.left, padding.top displacement to make it centered
    text.position = Vector2((size.x - textSize.x) / 2, (size.y - textSize.y) / 2);

    add(text);
  }

  @override
  void render(Canvas canvas) {
    // Draw rounded background
    final paint = Paint()..color = backgroundColor;
    final rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Radius.circular(cornerRadius),
    );
    canvas.drawRRect(rRect, paint);

    // Draw border
    if (borderWidth > 0) {
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;
      canvas.drawRRect(rRect, borderPaint);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    onPressed?.call();
  }
}