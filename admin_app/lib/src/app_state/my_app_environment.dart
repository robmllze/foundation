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

import '/_common.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

late final MyAppEnvironment app;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyAppEnvironment extends AppEnvironment<MyAppSession> {
  //
  //
  //

  MyAppEnvironment(super.serviceEnvironment);

  //
  //
  //

  late final state = MyAppStateManager(this);

  //
  //
  //

  @override
  MyAppSession createAppSession() => MyAppSession(this.serviceEnvironment);

  //
  //
  //

  @override
  void defineAuthStateChangesBehaviour() {
    var didAlreadyStartApp = false;
    // If the user gets logged in at any point:
    this.serviceEnvironment.authServiceBroker.onLogin = (currentUser) async {
      this.pAppSession.value.startSession(currentUser);

      final initConfiguration =
          this.routeManager.pScreenBreadcrumbs.value.lastOrNull?.configuration;
      late final ModelScreenConfiguration targetConfiguration;

      // If the app has not yet started:
      if (didAlreadyStartApp == false) {
        didAlreadyStartApp = true;
        targetConfiguration = initConfiguration ??
            this.routeManager.defaultOnLoginScreenConfiguration ??
            this.routeManager.defaultOnLogoutScreenConfiguration;
      }
      // If the app has already started:
      else {
        targetConfiguration = this.routeManager.defaultOnLoginScreenConfiguration ??
            this.routeManager.defaultOnLogoutScreenConfiguration;
      }
      final targetScreen = findScreenFromConfigurationAndAuthService(
        configuration: targetConfiguration,
        authServiceBroker: this.serviceEnvironment.authServiceBroker,
      );
      await this.routeManager.pScreenBreadcrumbs.set(Queue.of([targetScreen].nonNulls));
      Future.delayed(Duration.zero, () => this.routeManager.go(targetConfiguration));
    };

    // If the user gets logged out at any point:
    this.serviceEnvironment.authServiceBroker.onLogout = () async {
      final initConfiguration =
          this.routeManager.pScreenBreadcrumbs.value.lastOrNull?.configuration;
      late final ModelScreenConfiguration targetConfiguration;

      // If the app has not yet started:
      if (didAlreadyStartApp == false) {
        didAlreadyStartApp = true;
        targetConfiguration =
            initConfiguration ?? this.routeManager.defaultOnLogoutScreenConfiguration;
      }
      // If the app has already started:
      else {
        this.pAppSession.value.stopSession();
        targetConfiguration = this.routeManager.defaultOnLogoutScreenConfiguration;
      }
      final targetScreen = findScreenFromConfigurationAndAuthService(
        configuration: targetConfiguration,
        authServiceBroker: this.serviceEnvironment.authServiceBroker,
      );
      await this.routeManager.pScreenBreadcrumbs.set(Queue.of([targetScreen].nonNulls));
      Future.delayed(Duration.zero, () => this.routeManager.go(targetConfiguration));
    };
  }

  //
  //
  //

  late final routeManager = RouteManager(
    authServiceBroker: this.serviceEnvironment.authServiceBroker,
    findScreen: findScreenFromConfigurationAndAuthService,
    generatedScreenRoutes: generatedScreenRoutes,
    defaultOnLoginScreenConfiguration: HomeScreenConfiguration(),
    defaultOnLogoutScreenConfiguration: WelcomeScreenConfiguration(),
  );

  //
  //
  //

  final localeManager = LocaleManager(
    locales: {
      Languages.AFRIKAANS_ZA,
      Languages.ENGLISH_US,
      Languages.GERMAN_DE,
      Languages.SPANISH_MX,
    },
  );
}
