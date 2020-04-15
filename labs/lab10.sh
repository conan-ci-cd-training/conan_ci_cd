#!/bin/bash

## lab10: 

conan_build_info --v2 start app1 2

conan graph lock App/1.0@mycompany/stable --profile=debug-gcc6 --lockfile=conan.lock -r conan-develop
conan install App/1.0@mycompany/stable --lockfile=conan.lock --build=missing
conan upload App/1.0@mycompany/stable -r conan-tmp --confirm  --force --all
conan_build_info --v2 create debug_bi.json --lockfile=conan.lock --user=conan --password=conan2020

conan graph lock App/1.0@mycompany/stable --profile=release-gcc6 --lockfile=conan.lock -r conan-develop
conan install App/1.0@mycompany/stable --lockfile=conan.lock --build=missing
conan upload App/1.0@mycompany/stable -r conan-tmp --confirm  --force --all
conan_build_info --v2 create release_bi.json --lockfile=conan.lock --user=conan --password=conan2020

conan_build_info --v2 update --output-file app_bi.json debug_bi.json release_bi.json && cat app_bi.json

conan_build_info --v2 publish app_bi.json --url=http://jfrog.local:8081/artifactory --user=conan --password=conan2020

conan_build_info --v2 stop