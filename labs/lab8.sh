#!/bin/bash

## lab8: 

conan upload libD/1.0@mycompany/stable -r conan-tmp --confirm  --force --all
conan upload App/1.0@mycompany/stable -r conan-tmp --confirm  --force --all
