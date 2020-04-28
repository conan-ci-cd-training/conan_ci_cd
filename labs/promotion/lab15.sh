#!/bin/bash

## lab15: 

cd /home/conan/conan_ci_cd/labs/promotion

jfrog rt bpr debian-app 1 app-debian-uat-local --status="SIT_OK"  --comment="passed integration tests" --include-dependencies=false --copy=false
