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

import 'dart:convert';
import 'dart:io';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> deployToWebHosting({
  required String app,
  required ServiceEnvironmentType environment,
  required String deploymentSite,
  bool skipBuild = false,
  WebRenderer webRenderer = WebRenderer.CANVASKIT,
}) async {
  // 1. Define paths.
  final workingDirectory = Directory.fromUri(Platform.script).parent.path;
  final rootDir = "$workingDirectory/../..";
  final appDir = "$rootDir/$app";
  final appBuildDir = Directory("$appDir/build/web");
  final firebaseDir = "$rootDir/firebase_${environment.name.toLowerCase()}";
  final firebasePublicDir = "$firebaseDir/public";
  final firebaseJsonFilePath = File("$firebaseDir/firebase.json");

  // 2. Clear the Firebase public directory.
  final publicDir = Directory(firebasePublicDir);
  if (publicDir.existsSync()) {
    publicDir.deleteSync(recursive: true);
  }

  if (!skipBuild) {
    // 3. Clear the app's build directory.
    if (appBuildDir.existsSync()) {
      appBuildDir.deleteSync(recursive: true);
    }
    // 4. Build files to the app's build directory.
    final flutterBuildResult = await Process.run(
      "flutter",
      [
        "build",
        "web",
        if (environment == ServiceEnvironmentType.PROD) "--release",
        "--web-renderer",
        "${webRenderer.name.toLowerCase()}",
        "--dart-define=SERVICE_ENVIRONMENT=${environment.name}",
        () {
          final key = "YOUR_${environment.name.toUpperCase()}_FIREBASE_API_KEY";
          final value = Platform.environment[key];
          if (value == null) {
            throw Exception("Environment variable $key not found. Did you forget to set it?");
          }
          return "--dart-define=$key=$value";
        }(),
      ],
      workingDirectory: appDir,
    );
    if (flutterBuildResult.exitCode != 0) {
      throw Exception(
        "Flutter build failed:\n${flutterBuildResult.stdout}\n${flutterBuildResult.stderr}",
      );
    }
  }

  // 5. Copy the app's build files to Firebase public directory.
  appBuildDir.listSync(recursive: true).forEach((e) {
    final newPath = e.path.replaceFirst(appBuildDir.path, firebasePublicDir);
    if (e is File) {
      Directory(newPath).parent.createSync(recursive: true);
      e.copySync(newPath);
    } else if (e is Directory) {
      Directory(newPath).createSync(recursive: true);
    }
  });

  // 5. Update firebase.json.
  if (firebaseJsonFilePath.existsSync()) {
    final jsonContent = jsonDecode(firebaseJsonFilePath.readAsStringSync());
    jsonContent["hosting"]["site"] = deploymentSite;
    firebaseJsonFilePath.writeAsStringSync(jsonEncode(jsonContent));

    // 6. Deploy to Firebase.
    final firebaseDeployResult = await Process.run(
      "firebase",
      [
        "deploy",
        "--only",
        "hosting",
      ],
      workingDirectory: firebaseDir,
    );
    print(firebaseDeployResult.stdout);
    print(firebaseDeployResult.stderr);
  } else {
    throw Exception("Firebase config file not found: ${firebaseJsonFilePath.path}");
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String? extractFirebaseApiKeyFromArgs(List<String> args) {
  for (int i = 0; i < args.length; i++) {
    if (args[i] == "--firebase_api_key" && i + 1 < args.length) {
      return args[i + 1];
    }
  }
  return null;
}

enum WebRenderer {
  HTML,
  CANVASKIT,
  AUTO,
}

enum ServiceEnvironmentType {
  TEST,
  PROD,
}