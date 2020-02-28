#!/bin/bash

echo "Clone libraries"

git clone https://github.com/conan-ci-cd-training/libA.git
git clone https://github.com/conan-ci-cd-training/libB.git
git clone https://github.com/conan-ci-cd-training/libC.git
git clone https://github.com/conan-ci-cd-training/App.git
git clone https://github.com/conan-ci-cd-training/jenkins.git

echo "Configure Conan"

conan config install https://github.com/conan-ci-cd-training/settings.git
conan remote add conan-develop http://$AR_URL/artifactory/api/conan/conan-develop
conan remote add conan-tmp http://$AR_URL/artifactory/api/conan/conan-tmp
conan user -p $AR_PASSWORD -r conan-develop admin
conan user -p $AR_PASSWORD -r conan-tmp admin

echo "Create packages for debug and release profiles"

conan create libA mycompany/stable --profile debug-gcc6
conan create libB mycompany/stable --profile debug-gcc6
conan create libC mycompany/stable --profile debug-gcc6
conan create App mycompany/stable --profile debug-gcc6

conan create libA mycompany/stable --profile release-gcc6
conan create libB mycompany/stable --profile release-gcc6
conan create libC mycompany/stable --profile release-gcc6
conan create App mycompany/stable --profile release-gcc6

echo "Upload packages"

conan upload '*' --all -r conan-tmp --confirm  --force
conan upload '*' --all -r conan-develop --confirm  --force