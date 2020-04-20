#!/bin/bash

conan graph lock App/1.0@mycompany/stable --profile=debug-gcc6 --lockfile=app_debug.lock -r conan-develop

# 2020/04 : bug detected 
# lockfile as to be named conan.lock for "conan install" otherwise, it's not updated
for i in libD App; do 
  cp app_debug.lock conan.lock
  conan install ${i}/1.0@mycompany/stable --profile=debug-gcc6 --build ${i} --lockfile conan.lock
  conan graph update-lock app_debug.lock conan.lock
  rm -f conan.lock
done

conan upload "*" -r conan-develop --confirm  --all
