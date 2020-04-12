#!/bin/bash

## lab6: 

conan install App/1.0@mycompany/stable --profile=release-gcc6 -r conan-develop
conan install libB/1.0@mycompany/stable#e736204bc19388683c3c4de92b474f5c --profile=release-gcc6 -r conan-tmp --update
conan graph lock App/1.0@mycompany/stable --profile=release-gcc6 --lockfile=app_release.lock
cat app_release.lock