#!/bin/bash

## lab8: 

curl --user "conan:conan2020" --header "Content-Type: application/json" http://jfrog.local:8081/artifactory/conan-metadata/App/1.0@mycompany/stable/gcc6-release/conan.lock --upload-file app_release.lock
