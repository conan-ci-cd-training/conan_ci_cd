#!/bin/bash

## lab10: 


git clone https://github.com/conan-ci-cd-training/App2.git && cd App2
conan_build_info --v2 start app2 1 && cat ~/.conan/artifacts.properties

# create App2 release package
conan graph lock . --profile=debug-gcc6 --lockfile=app2_debug.lock -r conan-develop
conan create . mycompany/stable --lockfile=app2_debug.lock 

# create App2 debug package
conan graph lock . --profile=release-gcc6 --lockfile=app2_release.lock -r conan-develop
conan create . mycompany/stable --lockfile=app2_release.lock 

# upload App2
conan upload App2/1.0@mycompany/stable -r conan-develop --all  --confirm --force

# create build infos
conan_build_info --v2 create debug_bi.json --lockfile=app2_debug.lock --user=conan --password=conan2020 && cat debug_bi.json 
conan_build_info --v2 create release_bi.json --lockfile=app2_release.lock --user=conan --password=conan2020 && cat release_bi.json 

# create the aggregated build info
conan_build_info --v2 update --output-file app2_bi.json debug_bi.json release_bi.json && cat app2_bi.json

# publish the build info and remove build properties
conan_build_info --v2 publish app2_bi.json --url=http://jfrog.local:8081/artifactory --user=conan --password=conan2020
conan_build_info --v2 stop && cat ~/.conan/artifacts.properties