import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flame/flame.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:vampire_survivors_flame/my_app.dart';
import 'package:vampire_survivors_flame/src/bootstrap/app_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final layout = await resolveAppLayout();
  final isDesktop = Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  // Set up window manager for desktop platforms
  if (isDesktop) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      size: layout.totalSize,
      minimumSize: layout.totalSize,
      maximumSize: layout.totalSize,
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      title: 'Vampire Survivors',
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setAspectRatio(layout.aspectRatio);
    });
  }

  if (!isDesktop) {
    await Flame.device.fullScreen();
  }

  runApp(ProviderScope(child: MyApp(layout: layout)));
}
