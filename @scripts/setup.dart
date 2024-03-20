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
  await Future.wait([
    $("git clone -b main ${src}foundation.git $name"),
    $("git submodule init ___generators", name),
    $("git submodule initt _data", name),
    $("git submodule init _service_interfaces", name),
    $("git submodule init _view", name),
    $("git clone -b $servicesBranchName ${src}_services-foundation.git _services", name),
  ]);
  await Future.wait([
    $("dart pub get -C ___generators", name),
    $("dart pub get -C _data", name),
    $("dart pub get -C _service_interfaces", name),
    $("dart pub get -C _services", name),
    $("dart pub get -C _view", name),
    $("code my.code-workspace", name),
  ]);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<ProcessResult> $(
  String command, [
  String? workingDirectory,
]) async {
  final parts = command.split(" ");
  return await Process.run(
    parts[0],
    parts.sublist(1),
    workingDirectory: workingDirectory,
  );
}
