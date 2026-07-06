import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'app/app.dart';

Future<void> configureFullscreenLaunch() async {
  await windowManager.ensureInitialized();
  await windowManager.setFullScreen(true);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureFullscreenLaunch();
  runApp(const ProviderScope(child: TraceBenchApp()));
}
