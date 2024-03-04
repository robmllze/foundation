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

/// The `AppEnvironment` manages how the app behaves to changes in the user's
/// authentication state.
class AppEnvironment {
  //
  //
  //

  AppSession? _activeSession;

  final ServiceEnvironment serviceEnvironment;

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

  AppEnvironment(this.serviceEnvironment);

  //
  //
  //

  void initApp(AppSession appSession) async {
    this.setActiveSession(appSession);
    this._defineAuthStateChangesBehaviour();
  }

  //
  //
  //

  // Define how the app behaves to changes in the user's authentication state.
  void _defineAuthStateChangesBehaviour() {
    var didAlreadyStartApp = false;
    // If the user gets logged in at any point:
    this.serviceEnvironment.authServiceBroker.onLogin =
        (final currentUser) async {
      assert(this._activeSession != null);
      await this._activeSession?.startSession(currentUser);

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
        targetConfiguration =
            this.routeManager.defaultOnLoginScreenConfiguration ??
                this.routeManager.defaultOnLogoutScreenConfiguration;
      }
      final targetScreen = findScreenFromConfigurationAndAuthService(
        configuration: targetConfiguration,
        authServiceBroker: this.serviceEnvironment.authServiceBroker,
      );
      await this
          .routeManager
          .pScreenBreadcrumbs
          .set(Queue.of([targetScreen].nonNulls));
      Future.delayed(
          Duration.zero, () => this.routeManager.go(targetConfiguration));
    };

    // If the user gets logged out at any point:
    this.serviceEnvironment.authServiceBroker.onLogout = () async {
      final initConfiguration =
          this.routeManager.pScreenBreadcrumbs.value.lastOrNull?.configuration;
      late final ModelScreenConfiguration targetConfiguration;

      // If the app has not yet started:
      if (didAlreadyStartApp == false) {
        didAlreadyStartApp = true;
        targetConfiguration = initConfiguration ??
            this.routeManager.defaultOnLogoutScreenConfiguration;
      }
      // If the app has already started:
      else {
        assert(this._activeSession != null);
        await this._activeSession?.stopSession();
        targetConfiguration =
            this.routeManager.defaultOnLogoutScreenConfiguration;
      }
      final targetScreen = findScreenFromConfigurationAndAuthService(
        configuration: targetConfiguration,
        authServiceBroker: this.serviceEnvironment.authServiceBroker,
      );
      await this
          .routeManager
          .pScreenBreadcrumbs
          .set(Queue.of([targetScreen].nonNulls));
      Future.delayed(
          Duration.zero, () => this.routeManager.go(targetConfiguration));
    };
  }

  //
  //
  //

  void setActiveSession(AppSession newSession) {
    this._activeSession = newSession;
  }
}
