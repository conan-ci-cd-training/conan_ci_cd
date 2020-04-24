#!/bin/bash

## lab5: 

# update cache with a specific revision of libB (doesn’t update libA in the cache)

conan download libB/1.0@mycompany/stable#a6c44191b4b5391c3678ae1d458375ec -r conan-tmp --recipe

# check App
conan graph lock App/1.0@mycompany/stable --profile=release-gcc6 --lockfile=app_release.lock -r conan-develop

conan graph build-order app_release.lock --build missing --json app_bo.json

cat app_bo.json

# we already have libB in the cache

# check App2

conan graph lock App2/1.0@mycompany/stable --profile=release-gcc6 --lockfile=app2_release.lock -r conan-develop

conan graph build-order app2_release.lock --build missing --json app2_bo.json

cat app2_bo.json
