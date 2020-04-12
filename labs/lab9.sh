#!/bin/bash

## lab9: TODO

conan upload libD/1.0@mycompany/stable -r conan-tmp --confirm  --force --all
conan upload App/1.0@mycompany/stable -r conan-tmp --confirm  --force --all