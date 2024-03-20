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
    "admin_app",
    "operations_app",
    "public_app",
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
      "url": "https://github.com/robmllze/___generators.git"
    },
    {
      "name": "_data-foundation",
      "branch": "main",
      "url": "https://github.com/robmllze/_data-foundation.git"
    },
    {
      "name": "_service_interfaces-foundation",
      "branch": "main",
      "url": "https://github.com/robmllze/_service_interfaces-foundation.git"
    },
    {
      "name": "_view-foundation",
      "branch": "main",
      "url": "https://github.com/robmllze/_view-foundation.git"
    },
    {
      "name": "_services-foundation",
      "branch": servicesBranchName,
      "url": "https://github.com/robmllze/_services-foundation.git"
    },
  ];

  for (final repo in repos) {
    await Process.run("git", ["clone", "-b", repo["branch"]!, repo["url"]!, repo["name"]!]);
    if (repo["name"] == "foundation") {
      Directory.current = Directory("${Directory.current.path}/${repo["name"]}");
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> getDependencies(List<String> projectDirs) async {
  for (final dir in projectDirs) {
    await Process.run("dart", ["pub", "get", "-C", dir]);
  }
}
