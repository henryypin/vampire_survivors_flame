import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:vampire_survivors_flame/my_game.dart';

class FloatingJoystickComponent extends PositionComponent
    with DragCallbacks, HasGameReference<MyGame> {
  FloatingJoystickComponent()
    : _backgroundPaint = Paint()..color = const Color(0xDDFFFFFF),
      _knobPaint = Paint()..color = const Color(0xBBFFFFFF),
      super(anchor: Anchor.topLeft, priority: 100);

  static const double _backgroundRadius = 30;
  static const double _knobRadius = 15;
  static const double _maxKnobDistance = _backgroundRadius - _knobRadius / 2;

  final Paint _backgroundPaint;
  final Paint _knobPaint;
  final Vector2 _basePosition = Vector2.zero();
  final Vector2 _knobOffset = Vector2.zero();

  int? _activePointerId;
  bool _isVisible = false;

  Vector2 get relativeDelta => _knobOffset / _maxKnobDistance;

  @override
  FutureOr<void> onLoad() {
    size = game.camera.viewport.virtualSize;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = game.camera.viewport.virtualSize;
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onDragStart(DragStartEvent event) {
    if (_activePointerId != null) {
      return;
    }

    super.onDragStart(event);
    _activePointerId = event.pointerId;
    _isVisible = true;
    _basePosition.setFrom(_clampBasePosition(event.localPosition));
    _knobOffset.setZero();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (event.pointerId != _activePointerId) {
      return;
    }

    final dragOffset = event.localEndPosition - _basePosition;
    if (dragOffset.length > _maxKnobDistance) {
      dragOffset.scaleTo(_maxKnobDistance);
    }
    _knobOffset.setFrom(dragOffset);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (event.pointerId != _activePointerId) {
      return;
    }

    super.onDragEnd(event);
    _reset();
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    if (event.pointerId != _activePointerId) {
      return;
    }

    super.onDragCancel(event);
    _reset();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (!_isVisible) {
      return;
    }

    canvas.drawCircle(
      _basePosition.toOffset(),
      _backgroundRadius,
      _backgroundPaint,
    );
    canvas.drawCircle(
      (_basePosition + _knobOffset).toOffset(),
      _knobRadius,
      _knobPaint,
    );
  }

  Vector2 _clampBasePosition(Vector2 point) {
    return Vector2(
      point.x.clamp(_backgroundRadius, size.x - _backgroundRadius),
      point.y.clamp(_backgroundRadius, size.y - _backgroundRadius),
    );
  }

  void _reset() {
    _activePointerId = null;
    _isVisible = false;
    _knobOffset.setZero();
  }
}
