import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasPaint {
  Vector2 velocity = Vector2.zero();

  Player({
    required super.position,
    required super.size,
    required Paint paint,
    super.priority,
  }) {
    super.paint = paint;
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Simple triangle "character" — you can replace with Sprite later
    final path = Path()
      ..moveTo(0, -size.y / 2)
      ..lineTo(-size.x / 2, size.y / 2)
      ..lineTo(size.x / 2, size.y / 2)
      ..close();

    canvas.drawPath(path, paint);
  }
}