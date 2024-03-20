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

# Clone repositories.
git clone -b main https://github.com/robmllze/foundation.git foundation
Set-Location foundation
git clone -b main https://github.com/robmllze/___generators.git
git clone -b main https://github.com/robmllze/_data-foundation.git _data
git clone -b main https://github.com/robmllze/_service_interfaces-foundation.git _service_interfaces
git clone -b main https://github.com/robmllze/_view-foundation.git _view
git clone -b main https://github.com/robmllze/_services-foundation.git _services

# Get dependencies.
dart pub get -C ___generators
dart pub get -C _data
dart pub get -C _service_interfaces
dart pub get -C _services
dart pub get -C _view
dart pub get -C admin_app
dart pub get -C operations_app
dart pub get -C public_app

# Open code workspace.
code my.code-workspace


