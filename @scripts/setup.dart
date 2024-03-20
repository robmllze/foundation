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

import "dart:io";

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main(List<String> args) async {
  final servicesBranchName = args.isNotEmpty ? args[0] : "with_firebase";
  final src = "https://github.com/robmllze/";
  final name = "foundation";
  await $("git clone --recurse-submodules -b main ${src}foundation.git $name");
  await Future.wait([
    $("git checkout main", [name, "___generators"]),
    $("git checkout main", [name, "_data"]),
    $("git checkout main", [name, "_service_interfaces"]),
    $("git checkout $servicesBranchName", [name, "_services"]),
    $("git checkout main", [name, "_view"]),
  ]);
  await Future.wait([
    $("dart pub get", [name, "___generators"]),
    $("dart pub get", [name, "_data"]),
    $("dart pub get", [name, "_service_interfaces"]),
    $("dart pub get", [name, "_services"]),
    $("dart pub get", [name, "_view"]),
    $("code my.code-workspace", [name]),
  ]);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<ProcessResult> $(
  String command, [
  List<String> workingDirectory = const [],
]) async {
  final parts = command.split(" ");
  return await Process.run(
    parts[0],
    parts.sublist(1),
    workingDirectory: workingDirectory.isNotEmpty ? workingDirectory.join("/") : null,
  );
}
