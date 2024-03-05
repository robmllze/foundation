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

import '/firebase_options_test.dart' as firebase_options_test;

import '/_common.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

final pAppEnvironment = Pod<MyAppEnvironment?>(null);

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyAppEnvironment extends AppEnvironment<MyAppSession> {
  //
  //
  //

  MyAppEnvironment(super.serviceEnvironment);

  //
  //
  //

  @override
  MyAppSession createAppSession() => MyAppSession(this.serviceEnvironment);

  //
  //
  //

  /// Define what happens when the user is logged in for the first time after
  /// freshly opening the app.
  @override
  void onFreshLogin(UserInterface currentUser) async {
    /*await*/ this.pAppSession.value.startSession(currentUser);
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
  void onLogin(UserInterface currentUser) async {
    /*await*/ this.pAppSession.value.startSession(currentUser);
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
    await this.routeManager.pScreenBreadcrumbs.set(Queue.of([targetScreen].nonNulls));
    Future.delayed(Duration.zero, () => this.routeManager.go(to));
  }

  //
  //
  //

  late final routeManager = RouteManager(
    authServiceBroker: this.serviceEnvironment.authServiceBroker,
    findScreen: findScreenFromConfigurationAndAuthService,
    generatedScreenRoutes: generatedScreenRoutes,
    defaultOnLoginScreenConfiguration: HomeScreenConfiguration(),
    defaultOnLogoutScreenConfiguration: LoginScreenConfiguration(),
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

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void createEnvironment() async {
  // 1. Create a service environment to interact with backend services.
  final serviceEnvironment = await createFirebaseServiceEnvironment(
    {
      ServiceEnvironmentType.TEST: firebase_options_test.DefaultFirebaseOptions.currentPlatform,
    }[ServiceEnvironment.currentServiceEnvironment]!,
  );
  // 2. Create an app environment to hold the state of the app.
  final appEnvironment = MyAppEnvironment(serviceEnvironment);
  await pAppEnvironment.set(appEnvironment);
}
