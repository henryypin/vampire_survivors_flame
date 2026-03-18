import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vampire_survivors_flame/my_game.dart';
import 'package:vampire_survivors_flame/src/players/player.dart';
import 'package:vampire_survivors_flame/src/widgets/dynamic_joystick.dart';

class PlayScreen extends Component
    with HasGameReference<MyGame>, RiverpodComponentMixin {
  late Player player;
  late RectangleComponent worldBoundary;
  late JoystickComponent joystick;

  @override
  FutureOr<void> onLoad() async {
    // ─────── WORLD BOUNDARY (big green area) ───────
    worldBoundary = RectangleComponent(
      position: Vector2(-5000, -5000),
      size: Vector2(10000, 10000),
      paint: Paint()..color = const Color(0xFF88CC88),
      priority: -100,
    );
    game.world.add(worldBoundary);

    // ─────── Some example obstacles ───────
    for (int i = 0; i < 8; i++) {
      game.world.add(
        RectangleComponent(
          position: Vector2((i * 250).toDouble(), (i * 120).toDouble() - 200),
          size: Vector2(60, 60),
          paint: Paint()..color = const Color(0xFF006600),
          priority: 0,
        ),
      );
    }

    // ─────── Player (always centered on screen) ───────
    player = Player(
      position: Vector2.zero(), // will be kept at screen center
      size: Vector2(40, 60),
      paint: Paint()..color = Colors.deepPurpleAccent,
      priority: 10,
    );
    game.world.add(player);

    // Make camera follow player (player stays in center)
    game.camera.follow(player);
    // Optional: tune zoom / viewport if needed
    // camera.viewfinder.zoom = 1.2;

    // ─────── Virtual Joystick (appears on drag) ───────
    joystick = DynamicJoystick();

    // Important: we add joystick to the HUD layer (not world!)
    game.camera.viewport.add(joystick);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (joystick.delta.length > 5) {
      // Normalize direction and apply speed
      final direction = joystick.delta.normalized();
      final speed = 220.0; // pixels per second

      player.velocity = direction * speed;

      // Try move → then clamp
      final attempted = player.position + player.velocity * dt;
      final clamped = _clampToBoundary(attempted);

      player.position = clamped;
    } else {
      player.velocity = Vector2.zero();
    }
  }

  Vector2 _clampToBoundary(Vector2 candidate) {
    final left = worldBoundary.position.x + player.size.x / 2;
    final right = worldBoundary.position.x + worldBoundary.size.x - player.size.x / 2;
    final top = worldBoundary.position.y + player.size.y / 2;
    final bottom = worldBoundary.position.y + worldBoundary.size.y - player.size.y / 2;

    return Vector2(
      candidate.x.clamp(left, right),
      candidate.y.clamp(top, bottom),
    );
  }
}
