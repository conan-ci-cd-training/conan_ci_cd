#!/bin/bash

## lab6: 

conan download libB/1.0@mycompany/stable#e736204bc19388683c3c4de92b474f5c -r conan-tmp --recipe
conan graph lock App/1.0@mycompany/stable --profile=release-gcc6 --lockfile=app_release.lock -r conan-develop
cat app_release.lock