#!/bin/bash

## lab11: 

conan_build_info --v2 start app1 2

# profile release
conan graph lock libB/1.0@mycompany/stable --profile=release-gcc6 --lockfile=libB-release.lock
conan create libB mycompany/stable --lockfile=libB-release.lock

# profile debug
conan graph lock libB/1.0@mycompany/stable --profile=debug-gcc6 --lockfile=libB-debug.lock
conan create libB mycompany/stable --lockfile=libB-debug.lock --build=missing

conan upload libB --all -r conan-tmp --confirm

# create build info and merge
conan_build_info --v2 create bi-release.json --lockfile=libB-release.lock --user=conan --password=conan2020
conan_build_info --v2 create bi-debug.json --lockfile=libB-debug.lock --user=conan --password=conan2020
# merge build info & publish 
conan_build_info --v2 update --output-file final_bi.json bi-release.json bi-debug.json && cat final_bi.json
conan_build_info --v2 publish final_bi.json --url=http://jfrog.local:8081/artifactory --user=conan --password=conan2020
conan_build_info --v2 stop