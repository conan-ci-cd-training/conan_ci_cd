#!/bin/bash

## lab10: 

# create the aggregated build info
conan_build_info --v2 update --output-file app_bi.json debug_bi.json release_bi.json && cat app_bi.json

# publish the build info and remove build properties
conan_build_info --v2 publish app_bi.json --url=http://jfrog.local:8081/artifactory --user=conan --password=conan2020

conan_build_info --v2 stop && cat ~/.conan/artifacts.properties

