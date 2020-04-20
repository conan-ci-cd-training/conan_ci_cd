#!/bin/bash

## lab8: 

curl -u conan:conan2020 -X PUT "http://jfrog.local:8081/artifactory/conan-metadata/App/1.0@mycompany/stable/gcc6-release/app_release.lock" -T app_release.lock
