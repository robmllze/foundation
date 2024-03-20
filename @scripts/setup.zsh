#!/bin/zsh

##.title
## ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
##
## X|Y|Z & Dev
##
## Copyright Ⓒ Robert Mollentze, xyzand.dev
## 
## Licensing details can be found in the LICENSE file in the root directory.
## 
## ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
##.title~

# Get the services branch name from the first argument. Defaults to "with_firebase".
SERVICES_BRANCH_NAME=${1:-with_firebase}

# Clone repositories.
git clone -b main https://github.com/robmllze/foundation.git foundation
cd foundation
git clone -b main https://github.com/robmllze/___generators.git
git clone -b main https://github.com/robmllze/_data-foundation.git _data
git clone -b main https://github.com/robmllze/_service_interfaces-foundation.git _service_interfaces
git clone -b main https://github.com/robmllze/_view-foundation.git _view
git clone -b $SERVICES_BRANCH_NAME https://github.com/robmllze/_services-foundation.git _services

# Get dependencies.
dart pub get -C ___generators
dart pub get -C _data
dart pub get -C _service_interfaces
dart pub get -C _services
dart pub get -C _view
dart pub get -C admin_app
dart pub get -C operations_app
dart pub get -C public_app

# Open workspace.
code my.code-workspace
