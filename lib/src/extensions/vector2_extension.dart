import 'dart:math';

import 'package:flame/components.dart';

extension Vector2Extension on Vector2 {
  Vector2 cover(Vector2 target) {
    double scale = max(target.x / x, target.y / y);
    return this * scale;
  }

  Vector2 contain(Vector2 target) {
    double scale = min(target.x / x, target.y / y);
    return this * scale;
  }
}
