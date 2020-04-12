#!/bin/bash

## lab10: 

conan_build_info --v2 start app1 1 && cat ~/.conan/artifacts.properties

conan graph lock App/1.0@mycompany/stable --profile=release-gcc6 --lockfile=App-release.lock

conan create App mycompany/stable --lockfile=App-release.lock

conan upload */*@mycompany/stable --all -r conan-tmp --confirm

conan_build_info --v2 create build_info.json --lockfile=App-release.lock --user=conan --password=conan2020

cat build_info.json

conan_build_info --v2 publish build_info.json --url=http://jfrog.local:8081/artifactory --user=conan --password=conan2020

conan_build_info --v2 stop && cat ~/.conan/artifacts.properties