#!/bin/bash

## lab7: 

conan graph build-order app_release.lock --build missing
cp app_release.lock conan.lock
# use the build-order, build D
conan install libD/1.0@mycompany/stable#de8535f755c78e9d5db33f215b3c7865 --build libD --lockfile conan.lock
# lockfileD is updated with the node libD marked as built
conan graph update-lock app_release.lock conan.lock
conan graph build-order app_release.lock --build missing
# the build order with the updated lockfile → build App
cp app_release.lock conan.lock
conan install App/1.0@mycompany/stable#1de28c382bf878e39bad8184fc592c98 --build App --lockfile conan.lock
conan graph update-lock app_release.lock conan.lock
conan graph build-order app_release.lock --build missing