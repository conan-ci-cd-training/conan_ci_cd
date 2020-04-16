#!/bin/bash

## lab6: 

conan graph build-order app_release.lock --build missing --json app_bo.json

# use the build-order → build D
cp app_release.lock conan.lock

conan install libD/1.0@mycompany/stable --build libD --lockfile conan.lock

# lockfileD is updated with the node libD marked as built

# update the original lockfile with update-lock
conan graph update-lock app_release.lock conan.lock

# the build order with the updated lockfile → build App
cp app_release.lock conan.lock

conan install App/1.0@mycompany/stable --build App --lockfile conan.lock

conan graph update-lock app_release.lock conan.lock

conan graph build-order app_release.lock --build missing