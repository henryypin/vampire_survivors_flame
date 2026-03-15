import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flame/flame.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:vampire_survivors_flame/config.dart';
import 'package:vampire_survivors_flame/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up window manager for desktop platforms
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    await windowManager.ensureInitialized();
    final totalHeight = gameHeight + bannerHeight;
    final size = Size(gameWidth / 2, totalHeight / 2);
    WindowOptions windowOptions = WindowOptions(
      size: size,
      minimumSize: size,
      maximumSize: Size(gameWidth, totalHeight),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      title: 'Vampire Survivors',
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setAspectRatio(gameWidth / totalHeight);
    });
  }

  await Flame.device.fullScreen();

  runApp(ProviderScope(child: const MyApp()));
}
