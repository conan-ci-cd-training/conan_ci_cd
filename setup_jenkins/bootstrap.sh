#!/bin/bash

# bootstrap jenkins

# param 1: Orbitera IP
# param 2: Artifactory password
# param 3: Jenkins administrator password

permission=conan-ci2

curl -uadmin:$2 -XPOST http://$1/artifactory/api/security/groups/readers -d '{"autoJoin":"false"}' -H "Content-Type: application/json"

# create repo
sed "s/<REPO_NAME>/conan-tmp/" templates/create_repo.json > conan-tmp.json
sed "s/<REPO_NAME>/conan-develop/" templates/create_repo.json > conan-develop.json

curl -uadmin:$2 -XPUT http://$1/artifactory/api/repositories/conan-tmp -T conan-tmp.json -H "Content-Type: application/json"
curl -uadmin:$2 -XPUT http://$1/artifactory/api/repositories/conan-develop -T conan-develop.json -H "Content-Type: application/json"

# create user
sed "s/<USER>/myuser/" templates/create_user.json > user.json
curl -uadmin:$2 -XPUT http://$1/artifactory/api/security/users/myuser -T user.json -H "Content-Type: application/json"

# create permission
sed "s/<USER>/myuser/" templates/create_permission.json | sed "s/<NAME>/${permission}/"  | sed "s/<REPO1>/conan-tmp/"| sed "s/<REPO2>/conan-develop/"  > permission.json
curl -uadmin:$2 -XPUT http://$1/artifactory/api/v2/security/permissions/${permission} -T permission.json -H "Content-Type: application/json"


docker exec -it jenkins /bin/bash -c "curl https://raw.githubusercontent.com/conan-ci-cd-training/conan_ci_cd/master/setup_jenkins/init_jenkins.sh -O;chmod +x init_jenkins.sh;./init_jenkins.sh $1 $2 $3"
