import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/post_process.dart';

class PixelationPostProcess extends PostProcess {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _fragmentProgram = await FragmentProgram.fromAsset(
      'shaders/pixelation.frag',
    );
  }

  late final FragmentProgram _fragmentProgram;
  late final FragmentShader _fragmentShader = _fragmentProgram.fragmentShader();

  double _time = 0;

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;
  }

  late final myPaint = Paint()..shader = _fragmentShader;

  @override
  void postProcess(Vector2 size, Canvas canvas) {
    final preRenderedSubtree = rasterizeSubtree();

    _fragmentShader.setFloatUniforms((value) {
      value
        ..setVector(size / (20 * sin(_time)))
        ..setVector(size);
    });

    _fragmentShader.setImageSampler(0, preRenderedSubtree);

    canvas
      ..save()
      ..drawRect(Offset.zero & size.toSize(), myPaint)
      ..restore();
  }
}
