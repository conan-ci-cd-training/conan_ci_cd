#!/bin/bash

## lab8: 

# upload the lockfile to conan-metadata repo
curl -u conan:conan2020 -X PUT http://jfrog.local:8081/artifactory/conan-metadata/App/1.0@mycompany/stable/conan-app/1/gcc6-release/ -T app_release.lock

# assign some properties
curl -u conan:conan2020 -X PUT http://jfrog.local:8081/artifactory/api/storage/conan-metadata/App/1.0@mycompany/stable/conan-app/1/gcc6-release/app_release.lock?properties=build.name=conan-app%7Cbuild.number=1%7Cprofile=gcc6-release%7Capp.version=1.0
