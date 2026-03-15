import 'package:flutter/material.dart';

import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vampire_survivors_flame/config.dart';
import 'package:vampire_survivors_flame/my_game.dart';
import 'package:vampire_survivors_flame/src/providers/ad_provider.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final MyGame _game;

  @override
  void initState() {
    super.initState();
    _game = MyGame();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      // Simulate ad loading after a delay
      ref.read(adHeightProvider.notifier).setHeight(bannerHeight);
    });
  }

  @override
  Widget build(BuildContext context) {
    final adHeight = ref.watch(adHeightProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: RiverpodAwareGameWidget(
                key: GlobalKey<RiverpodAwareGameWidgetState<MyGame>>(),
                game: _game,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: double.infinity,
              height: adHeight.clamp(0.0, bannerHeight),
              color: Colors.black,
              // Replace this child with your real BannerAdWidget
              child: adHeight > 0
                  ? const Center(
                      child: Text('Ad', style: TextStyle(color: Colors.white)),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
