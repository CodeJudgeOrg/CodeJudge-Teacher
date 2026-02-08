import 'package:code_judge_teacher/l10n/app_localizations.dart';
import 'package:code_judge_teacher/layouts/desktop_layout.dart';
import 'package:code_judge_teacher/layouts/mobile_layout.dart';
import 'package:code_judge_teacher/layouts/tablet_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Define the app theme
    final ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime, brightness: Brightness.light),
      useMaterial3: true,
    );
    final ThemeData darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime, brightness: Brightness.dark),
      useMaterial3: true,
    );

    return MaterialApp(
      // Apply the theme
      title: 'CodeJudge',
      theme: lightTheme,
      darkTheme: darkTheme,
      // Apply settings & language
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate
      ],
      supportedLocales: const [Locale('en'), Locale('de')],
      locale: null,
      home: HomepageLayoutHandler(),
    );
  }
}

// Store the screen-type
enum ScreenType {mobile, tablet, desktop}

// Apply the correct layout depending on the screen-type
class HomepageLayoutHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        // Use the correct layout depending on ScreenType
        final screenType = getScreenType(constrains.maxWidth);
        switch (screenType) {
          case ScreenType.desktop:
          return DesktopLayout();
          case ScreenType.tablet:
            return TabletLayout();
          case ScreenType.mobile:
            return MobileLayout();
        }
      },
    );
  }
  // Define the screen-type
  ScreenType getScreenType (double width) {
    // For desktops
    if (width >= 1200) {
      return ScreenType.desktop;
    }
    // For tablets
    if (width >= 900) {
      return ScreenType.tablet;
    }
    // Else it's a mobile phone
    return ScreenType.mobile;
  }
}
