import 'dart:async';

import 'package:flame/components.dart';
import 'package:vampire_survivors_flame/src/components/hero_component.dart';

class PlayScreen extends Component {
  late final HeroComponent _player;

  @override
  FutureOr<void> onLoad() {
    _player = HeroComponent();
    add(_player);
  }
}
