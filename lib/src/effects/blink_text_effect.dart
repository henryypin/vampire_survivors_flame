import 'package:flame/effects.dart';
import 'package:flame/components.dart';

class BlinkTextEffect extends Effect with EffectTarget<TextComponent> {
  BlinkTextEffect(super.controller);

  late String _originalText;

  @override
  void onStart() {
    super.onStart();
    _originalText = target.text;
  }

  @override
  void apply(double progress) {
    target.text = progress < 0.5 ? '' : _originalText;
  }
}
