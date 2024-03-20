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

Push-Location ___generators
flutter clean
flutter pub get
Pop-Location

Push-Location _data
flutter clean
flutter pub get
Pop-Location

Push-Location _service_interfaces
flutter clean
flutter pub get
Pop-Location

Push-Location _services
flutter clean
flutter pub get
Pop-Location

Push-Location _view
flutter clean
flutter pub get
Pop-Location

Push-Location admin_app
flutter clean
flutter pub get
Pop-Location

Push-Location operations_app
flutter clean
flutter pub get
Pop-Location

Push-Location public_app
flutter clean
flutter pub get
Pop-Location
