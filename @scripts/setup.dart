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

  // Clone repositories
  await cloneRepositories(servicesBranchName);

  // Get dependencies for each project directory
  await getDependencies([
    "___generators",
    "_data",
    "_service_interfaces",
    "_services",
    "_view",
  ]);

  // Open workspace in VS Code
  await Process.run("code", ["my.code-workspace"]);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> cloneRepositories(String servicesBranchName) async {
  final repos = [
    {
      "name": "foundation",
      "branch": "main",
      "url": "https://github.com/robmllze/foundation.git",
    },
    {
      "name": "___generators",
      "branch": "main",
      "url": "https://github.com/robmllze/___generators.git",
    },
    {
      "name": "_data",
      "branch": "main",
      "url": "https://github.com/robmllze/_data-foundation.git",
    },
    {
      "name": "_service_interfaces",
      "branch": "main",
      "url": "https://github.com/robmllze/_service_interfaces-foundation.git",
    },
    {
      "name": "_view",
      "branch": "main",
      "url": "https://github.com/robmllze/_view-foundation.git",
    },
    {
      "name": "_services",
      "branch": servicesBranchName,
      "url": "https://github.com/robmllze/_services-foundation.git",
    },
  ];

  for (final r in repos) {
    print(["git", "clone", "-b", r["branch"]!, r["url"]!, r["name"]!].join(" "));
    await Process.run("git", ["clone", "-b", r["branch"]!, r["url"]!, r["name"]!]);
    if (r["name"] == "foundation") {
      Directory.current = Directory("${Directory.current.path}/${r["name"]}");
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> getDependencies(List<String> dirs) async {
  for (final dir in dirs) {
    await Process.run("dart", ["pub", "get", "-C", dir]);
  }
}
