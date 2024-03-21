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
  final fork = getArg(args, '-fork') ?? 'https://github.com/robmllze/foundation.git';
  final name = getArg(args, '-project') ?? 'foundation';
  await $('git clone --recurse-submodules -b main $fork $name');
  final submodules = [
    '___generators',
    '_data',
    '_service_interfaces',
    '_services',
    '_view',
  ];
  await Future.wait(submodules.map((e) => $('git checkout main', [name, e])));
  await Future.wait(submodules.map((e) => $('dart pub get', [name, e])));
  final nogit = getArg(args, '--nogit') == '';
  if (nogit) {
    rm("$name/.gitmodules");
    rm("$name/.git");
  }
  await $('code my.code-workspace', [name]);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String? getArg(List<String> args, String argName) {
  for (var i = 0; i < args.length; i++) {
    if (args[i] == argName) {
      if (i + 1 < args.length && !args[i + 1].startsWith('-')) {
        return args[i + 1];
      } else {
        return '';
      }
    }
  }
  return null;
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

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> rm(String path) async {
  var entity = FileSystemEntity.typeSync(path);
  if (entity == FileSystemEntityType.file) {
    print("Deleting file: $path");
    await File(path).delete();
  } else if (entity == FileSystemEntityType.directory) {
    print("Deleting directory: $path");
    await Directory(path).delete(recursive: true);
  }
}
