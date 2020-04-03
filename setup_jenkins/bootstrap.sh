#!/bin/bash

# bootstrap jenkins

# param 1: Orbitera IP
# param 2: Artifactory password
# param 3: Jenkins administrator password

docker exec -it jenkins /bin/bash -c "curl https://raw.githubusercontent.com/conan-ci-cd-training/conan_ci_cd/master/setup_jenkins/init_jenkins.sh -O;chmod +x init_jenkins.sh;./init_jenkins.sh $1 $2 $3"
