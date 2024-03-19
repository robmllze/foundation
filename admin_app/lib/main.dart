//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// X|Y|Z & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'package:url_strategy/url_strategy.dart';

import '/_common.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  createEnvironment();
  await AppScalePod(values: MyAppScale.values).getProperty();
  await AppThemePod(values: MyAppTheme.values).getProperty();
  await AppLocalePod(values: MyAppLocale.values).getProperty();
  runApp(const MainWidget());
}

enum MyAppScale with AppScaleEnumMixin {
  DEFAULT(1.0),
  SMALLER(0.75),
  LARGER(1.5);

  @override
  final double scale;

  const MyAppScale(this.scale);
}

enum MyAppTheme with AppThemeEnumMixin {
  LIGHT,
  DARK;

  @override
  ThemeData get themeData {
    switch (this) {
      case MyAppTheme.LIGHT:
        return ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            seedColor: Colors.grey.shade900,
            primary: Colors.grey.shade900,
          ),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: defaultTextTheme(),
        );
      case MyAppTheme.DARK:
        return ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Colors.grey.shade900,
            primary: Colors.grey.shade900,
          ),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: defaultTextTheme(),
        );
    }
  }
}


