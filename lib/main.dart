import 'package:flutter_design_system/extentions/custom_scroll_behavior.dart';
import 'package:flutter_design_system/main.directories.g.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter_design_system/themes/f_theme.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void main() {
  runApp(const WidgetBookApp());
}

@widgetbook.App()
class WidgetBookApp extends StatelessWidget {
  const WidgetBookApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      lightTheme: FTheme.light(context),
      darkTheme: FTheme.dark(context),
      themeMode: ThemeMode.dark,
      addons: [
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone13,
            Devices.ios.iPad,
          ],
          initialDevice: Devices.ios.iPhone13,
        ),
        InspectorAddon(),
        ThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: FTheme.light(context),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: FTheme.dark(context),
            ),
          ],
          themeBuilder: (context, theme, child) => MaterialApp(
            navigatorKey: navigatorKey,
            theme: theme,
            debugShowCheckedModeBanner: false,
            home: child,
            scrollBehavior: CustomScrollBehavior(),
          ),
          initialTheme: WidgetbookTheme(
            name: 'Light',
            data: FTheme.light(context),
          ),
        ),
        // GridAddon(),
        BuilderAddon(
          name: 'area',
          builder: (context, child) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(child: child),
            ),
            backgroundColor: FColors.of(context).backgroundNormalN,
          ),
        ),
      ],
    );
  }
}
