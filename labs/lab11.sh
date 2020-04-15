#!/bin/bash

## lab11: 

jfrog rt c --interactive=false  --url=http://jfrog.local:8081/artifactory --user=conan --password=conan2020 art7 
# generate and upload Debian package from App2 Conan package
cd ~/conan_ci_cd/labs && chmod +x generateDebianPkg.sh && ./generateDebianPkg.sh conan conan2020 

# create custom Build Info 
jfrog rt u debian_gen/myapp2_1.0.deb app-debian-sit-local/pool/ --build-name=myapp2 --build-number=1
jfrog rt d conan-metadata/app_release.lock --build-name=myapp2 --build-number=1
jfrog rt bad myapp2 1 conan_package.tgz
jfrog rt bce myapp2 1
jfrog rt bp myapp2 1

# Promote with JFrog CLI  
jfrog rt bpr myapp2 1 app-debian-uat-local --status="SIT_OK"  --comment="passed integration tests" --include-dependencies=false --copy=false
