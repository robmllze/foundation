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

/// A class to hold the entire state of the app.
class AppEnvironmentState extends AppEnvironment<AppSessionState> {
  //
  //
  //

  AppEnvironmentState(super.serviceEnvironment);

  //
  //
  //

  @override
  AppSessionState createAppSession() => AppSessionState(this.serviceEnvironment);

  //
  //
  //

  /// Define what happens when the user is logged in for the first time after
  /// freshly opening the app.
  @override
  void onFreshLogin(UserInterface user) async {
    Here().debugLogStart("Fresh login detected");
    /*await*/ this.pAppSession.value.startSession(user);
    final requested = this.routeManager.pScreenBreadcrumbs.value.lastOrNull?.configuration;
    await this._routeTo(
      requested ??
          this.routeManager.defaultOnLoginScreenConfiguration ??
          this.routeManager.defaultOnLogoutScreenConfiguration,
    );
  }

  //
  //
  //

  /// Define what happens when the user logs in after having logged out.
  @override
  void onLogin(UserInterface user) async {
    Here().debugLogStart("Login detected");
    /*await*/ this.pAppSession.value.startSession(user);
    await this._routeTo(
      this.routeManager.defaultOnLoginScreenConfiguration ??
          this.routeManager.defaultOnLogoutScreenConfiguration,
    );
  }

  //
  //
  //

  /// Define what happens when the user is logged out for the first time after
  /// freshly opening the app.
  @override
  void onFreshLogout() async {
    Here().debugLogStop("Fresh logout detected");
    final requested = this.routeManager.pScreenBreadcrumbs.value.lastOrNull?.configuration;
    await this._routeTo(
      requested ?? this.routeManager.defaultOnLogoutScreenConfiguration,
    );
  }

  //
  //
  //

  /// Define what happens when the user logs out after having logged in.
  @override
  void onLogout() async {
    Here().debugLogStop("Logout detected");
    /*await*/ this.pAppSession.value.stopSession();
    await this._routeTo(
      this.routeManager.defaultOnLogoutScreenConfiguration,
    );
  }

  //
  //
  //

  Future<void> _routeTo(ModelScreenConfiguration to) async {
    final targetScreen = findScreenFromConfigurationAndAuthService(
      configuration: to,
      authServiceBroker: this.serviceEnvironment.authServiceBroker,
    );

    await this.routeManager.pScreenBreadcrumbs.set(Queue.of([targetScreen!]));
    this.routeManager.go(targetScreen.configuration!);
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
