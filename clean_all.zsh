#!/bin/zsh

cd ___generators && flutter clean && flutter pub get && cd ..
cd _data && flutter clean && flutter pub get && cd ..
cd _service_interfaces && flutter clean && flutter pub get && cd ..
cd _services && flutter clean && flutter pub get &&  cd ..
cd _view && flutter clean && flutter pub get && cd ..

cd admin_app && flutter clean && flutter pub get && cd ..
cd operations_app && flutter clean && flutter pub get && cd ..
cd public_app && flutter clean && flutter pub get && cd ..