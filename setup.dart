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
  final name = getArg(args, '-name') ?? 'foundation';
  final mainBranch = getArg(args, '-main-branch') ?? 'main';
  final generatorsBranch = getArg(args, '-generators-branch') ?? 'main';
  final dataBranch = getArg(args, '-data-branch') ?? 'main';
  final serviceInterfacesBranch = getArg(args, '-service-interfaces-branch') ?? 'main';
  final servicesBranch = getArg(args, '-services-branch') ?? 'main';
  final viewBranch = getArg(args, '-view-branch') ?? 'main';
  final nogit = getArg(args, '--nogit') == '';
  await $('git clone --recurse-submodules -b $mainBranch $fork $name');
  final submodulesAndBranches = {
    '___generators': generatorsBranch,
    '_data': dataBranch,
    '_service_interfaces': serviceInterfacesBranch,
    '_services': servicesBranch,
    '_view': viewBranch,
  };
  await Future.wait(submodulesAndBranches.entries.map((e) {
    final submodule = e.key;
    final branch = e.value;
    return $('git checkout $branch', [name, submodule]);
  }));
  await Future.wait(submodulesAndBranches.keys.map((e) => $('dart pub get', [name, e])));
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
    await File(path).delete();
  } else if (entity == FileSystemEntityType.directory) {
    await Directory(path).delete(recursive: true);
  }
}
