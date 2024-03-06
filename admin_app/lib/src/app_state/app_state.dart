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

/// Holds the entire state of the app.
final pAppState = Pod<AppEnvironmentState?>(null);

/// Creates the app environment and initializes the state of the app.
Future<void> createEnvironment() async {
  await Future.delayed(
    Duration.zero,
    () async {
      // 1. Create a service environment to interact with backend services.
      final serviceEnvironment = await createFirebaseServiceEnvironment(
        {
          ServiceEnvironmentType.TEST: firebase_options_test.DefaultFirebaseOptions.currentPlatform,
        }[ServiceEnvironment.currentServiceEnvironment]!,
      );
      // 2. Create an app environment to hold the state of the app.
      final appEnvironment = AppEnvironmentState(serviceEnvironment);
      await pAppState.set(appEnvironment);
    },
  );
}
