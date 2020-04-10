#!/bin/bash

# bootstrap jenkins

# param 1: Artifactory password
# param 2: Jenkins administrator password

permission=conan-ci2
user=conan
password=conan2020
address=jfrog.local
artifactory_pass=$1
jenkins_pass=$2

## Artifactory configuration

curl -uadmin:${artifactory_pass} -XPOST http://${address}/artifactory/api/security/groups/readers -d '{"autoJoin":"false"}' -H "Content-Type: application/json"

# create repo
sed "s/<REPO_NAME>/conan-tmp/" templates/create_repo.json | sed "s/<REPO_TYPE>/conan/" | sed "s/<REPO_LAYOUT>/conan-default/" > conan-tmp.json
sed "s/<REPO_NAME>/conan-develop/" templates/create_repo.json | sed "s/<REPO_TYPE>/conan/" | sed "s/<REPO_LAYOUT>/conan-default/" > conan-develop.json
sed "s/<REPO_NAME>/conan-metadata/" templates/create_repo.json | sed "s/<REPO_TYPE>/generic/" | sed "s/<REPO_LAYOUT>/simple-default/" > conan-metadata.json

curl -uadmin:${artifactory_pass} -XPUT http://${address}/artifactory/api/repositories/conan-tmp -T conan-tmp.json -H "Content-Type: application/json"
curl -uadmin:${artifactory_pass} -XPUT http://${address}/artifactory/api/repositories/conan-develop -T conan-develop.json -H "Content-Type: application/json"
curl -uadmin:${artifactory_pass} -XPUT http://${address}/artifactory/api/repositories/conan-metadata -T conan-metadata.json -H "Content-Type: application/json"

# create user
sed "s/<USER>/${user}/" templates/create_user.json | sed "s/<PASSWORD>/${password}/" > user.json
curl -uadmin:${artifactory_pass} -XPUT http://${address}/artifactory/api/security/users/${user} -T user.json -H "Content-Type: application/json"

# create permission
sed "s/<USER>/${user}/" templates/create_permission.json | sed "s/<NAME>/${permission}/"  | sed "s/<REPO1>/conan-tmp/"| sed "s/<REPO2>/conan-develop/" | sed "s/<REPO3>/conan-metadata/" > permission.json
curl -uadmin:${artifactory_pass} -XPUT http://${address}/artifactory/api/v2/security/permissions/${permission} -T permission.json -H "Content-Type: application/json"

## Conan client configuration

conan config install https://github.com/conan-ci-cd-training/settings.git

conan remote add conan-develop http://${address}:8081/artifactory/api/conan/conan-develop
conan remote add conan-tmp http://${address}:8081/artifactory/api/conan/conan-tmp
conan user -p ${password} -r conan-develop ${user}
conan user -p ${password} -r conan-tmp ${user}

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

## Jenkins configuration

docker exec -it jenkins /bin/bash -c "curl https://raw.githubusercontent.com/conan-ci-cd-training/conan_ci_cd/master/setup_jenkins/init_jenkins.sh -O;chmod +x init_jenkins.sh;./init_jenkins.sh ${artifactory_pass} ${jenkins_pass}"
