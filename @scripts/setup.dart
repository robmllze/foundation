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

Future<void> main(List<String> args) async {
  final servicesBranchName = args.isNotEmpty ? args[0] : "with_firebase";
  final src = "https://github.com/robmllze/";
  await $("git clone -b main ${src}foundation.git foundation");
  Directory.current = "${Directory.current.path}/foundation";
  await $("git clone -b main ${src}___generators.git ___generators");
  await $("git clone -b main ${src}_data-foundation.git _data");
  await $("git clone -b main ${src}_service_interfaces-foundation.git _service_interfaces");
  await $("git clone -b main ${src}_view-foundation.git _view");
  await $("git clone -b $servicesBranchName ${src}_services-foundation.git _services");
  await $("dart pub get -C ___generators");
  await $("dart pub get -C _data");
  await $("dart pub get -C _service_interfaces");
  await $("dart pub get -C _services");
  await $("dart pub get -C _view");
  await $("dcode my.code-workspace");
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<ProcessResult> $(String command) async {
  final parts = command.split(" ");
  return await Process.run(parts[0], parts.sublist(1));
}
