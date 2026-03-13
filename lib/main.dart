import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() => runApp(const KenDigitalApp());

class KenDigitalApp extends StatelessWidget {
  const KenDigitalApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ken Digital Tech Hub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomeScreen(),
      scrollBehavior: const _ScrollBehavior(),
    );
  }
}

class _ScrollBehavior extends ScrollBehavior {
  const _ScrollBehavior();
  @override
  Widget buildScrollbar(BuildContext ctx, Widget child, ScrollableDetails d) => child;
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch, PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad, PointerDeviceKind.stylus,
  };
}