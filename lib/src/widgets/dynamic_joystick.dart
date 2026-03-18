import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class DynamicJoystick extends JoystickComponent {
  bool _isActive = false;
  Vector2? _dragStartPosition;

  DynamicJoystick()
      : super(
    knob: CircleComponent(
      radius: 22,
      paint: Paint()..color = Colors.white70,
    ),
    background: CircleComponent(
      radius: 55,
      paint: Paint()..color = Colors.black38,
    ),
    // position: Vector2.zero(),
    priority: 999,
  );



  @override
  bool onDragStart(DragStartEvent event) {
    _isActive = true;
    _dragStartPosition = event.localPosition.clone();
    position = _dragStartPosition! - background!.size / 2;
    // opacity = 1.0;
    return super.onDragStart(event);
  }

  @override
  bool onDragUpdate(DragUpdateEvent event) {
    if (!_isActive) return false;
    return super.onDragUpdate(event);
  }

  @override
  bool onDragEnd(DragEndEvent event) {
    _isActive = false;
    // opacity = 0.0;
    delta.setZero(); // important — stop movement
    return super.onDragEnd(event);
  }

  @override
  bool onDragCancel(DragCancelEvent event) {
    _isActive = false;
    // opacity = 0.0;
    delta.setZero();
    return super.onDragCancel(event);
  }
}