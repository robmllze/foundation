//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:io';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main(List<String> args) async {
  final repo = 'https://github.com/robmllze/foundation.git';
  final name = args.elementAtOrNull(0) ?? 'foundation';
  await $('git clone --recurse-submodules -b main $repo $name');
  final submodules = [
    '___generators',
    '_data',
    '_service_interfaces',
    '_services',
    '_view',
  ];
  await Future.wait(submodules.map((e) => $('git checkout main', [name, e])));
  await Future.wait(submodules.map((e) => $('dart pub get', [name, e])));
  await $('code my.code-workspace', [name]);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<bool> $(
  String command, [
  List<String> workingDirectory = const [],
]) async {
  try {
    final parts = command.split(' ');
    await Process.run(
      parts[0],
      parts.sublist(1),
      workingDirectory: workingDirectory.isNotEmpty ? workingDirectory.join('/') : null,
    );
    return true;
  } catch (_) {
    return false;
  }
}
