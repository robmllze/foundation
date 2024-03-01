#!/bin/zsh

git clone https://github.com/robmllze/___generators.git
git clone https://github.com/robmllze/_data-foundation.git _data
git clone https://github.com/robmllze/_service_interfaces-foundation.git _service_interfaces
git clone https://github.com/robmllze/_services-foundation.git _services
git clone https://github.com/robmllze/_view-foundation.git _view

cd ___generators && flutter pub get && cd ..
cd _data && flutter pub get && cd ..
cd _service_interfaces && flutter pub get && cd ..
cd _services && flutter pub get &&  cd ..
cd _view && flutter pub get && cd ..