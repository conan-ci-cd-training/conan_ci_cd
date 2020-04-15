#!/bin/bash

## lab2: 

git clone https://github.com/conan-ci-cd-training/libB.git
cd libB
git checkout feature/add_comments
# we want the library to be tested for different configurations: 

# generate lockfiles for all configurations (debug and release)
conan graph lock libB/1.0@mycompany/stable --lockfile=../lockfiles/debug.lock -r conan-develop --profile debug-gcc6 
conan graph lock libB/1.0@mycompany/stable --lockfile=../lockfiles/release.lock -r conan-develop --profile release-gcc6

# create packages with those lockfiles
conan create . mycompany/stable --lockfile=../lockfiles/debug.lock
conan create . mycompany/stable --lockfile=../lockfiles/release.lock