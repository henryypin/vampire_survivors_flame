import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vampire_survivors_flame/my_game.dart';
import 'package:vampire_survivors_flame/src/bootstrap/app_layout.dart';

class MyApp extends StatefulWidget {
  const MyApp({required this.layout, super.key});

  final AppLayout layout;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<RiverpodAwareGameWidgetState<MyGame>> _gameWidgetKey =
      GlobalKey<RiverpodAwareGameWidgetState<MyGame>>();
  late final MyGame _game;

  @override
  void initState() {
    super.initState();
    _game = MyGame();
  }

  @override
  Widget build(BuildContext context) {
    final layout = widget.layout;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Perfect DOS VGA 437'),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: ColoredBox(
          color: Colors.black,
          child: Column(
            children: [
              Expanded(
                child: RiverpodAwareGameWidget(
                  key: _gameWidgetKey,
                  game: _game,
                ),
              ),
              if (layout.bannerHeight > 0)
                SizedBox(
                  width: layout.totalSize.width,
                  height: layout.bannerHeight,
                  child: const ColoredBox(
                    color: Colors.black,
                    child: Center(
                      child: Text('Ad', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
