#!/bin/bash

## lab9:

# disable/enable build properties
conan_build_info --v2 stop && cat ~/.conan/artifacts.properties
conan_build_info --v2 start conan-app 1 && cat ~/.conan/artifacts.properties

# create build info for release from the release lockfile for App1
conan_build_info --v2 create release_bi.json --lockfile=app_release.lock --user=conan --password=conan2020 && cat release_bi.json 

# redo lab 6.a and 6.b to generate libs in Debug
# redo lab 7 to upload App in Debug
# current path : ~/conan_ci_cd/labs
./genAppDebug.sh

# create build info
conan_build_info --v2 create debug_bi.json --lockfile=app_debug.lock --user=conan --password=conan2020 && cat debug_bi.json

