import 'dart:io';
import 'dart:ui';

import 'package:vampire_survivors_flame/config.dart';

class AppLayout {
  const AppLayout({required this.bannerHeight});

  final double bannerHeight;

  Size get gameSize => const Size(gameWidth, gameHeight);

  Size get totalSize => Size(gameWidth, gameHeight + bannerHeight);

  double get aspectRatio => totalSize.width / totalSize.height;
}

Future<AppLayout> resolveAppLayout() async {
  final isMobileApp = Platform.isAndroid || Platform.isIOS;
  if (!isMobileApp) {
    return const AppLayout(bannerHeight: 0);
  }

  await Future.delayed(const Duration(seconds: 2));

  const resolvedBannerHeight = bannerHeight;

  return AppLayout(bannerHeight: resolvedBannerHeight);
}
