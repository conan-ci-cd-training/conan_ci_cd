#!/bin/bash

# bootstrap jenkins

# param 1: Artifactory password
# param 2: Jenkins administrator password

address="jfrog.local"
artifactory_pass=$1
jenkins_pass=$2

echo "Clone libraries"

cd /var/lib/jenkins

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

conan config install https://github.com/conan-ci-cd-training/settings.git

git clone https://github.com/conan-ci-cd-training/libA.git
git clone https://github.com/conan-ci-cd-training/libB.git
git clone https://github.com/conan-ci-cd-training/libC.git
git clone https://github.com/conan-ci-cd-training/libD.git
git clone https://github.com/conan-ci-cd-training/App.git
git clone https://github.com/conan-ci-cd-training/App2.git
git clone https://github.com/conan-ci-cd-training/products.git

conan export libA mycompany/stable
conan export libB mycompany/stable
conan export libC mycompany/stable
conan export libD mycompany/stable
conan export App mycompany/stable
conan export App2 mycompany/stable

conan remote add conan-develop http://${address}:8081/artifactory/api/conan/conan-develop
conan remote add conan-tmp http://${address}:8081/artifactory/api/conan/conan-tmp
conan user -p ${artifactory_pass} -r conan-develop admin
conan user -p ${artifactory_pass} -r conan-tmp admin

conan install App/1.0@mycompany/stable --profile debug-gcc6 --build missing -r conan-develop
conan install App2/1.0@mycompany/stable --profile debug-gcc6 --build missing -r conan-develop

conan install App/1.0@mycompany/stable --profile release-gcc6 --build missing -r conan-develop
conan install App2/1.0@mycompany/stable --profile release-gcc6 --build missing -r conan-develop

conan upload '*' -r conan-develop --all --confirm  --force

docker run --network="host" -it conanio/gcc8 /bin/bash -c "conan config install https://github.com/conan-ci-cd-training/settings.git;conan remote add conan-develop http://${address}:8081/artifactory/api/conan/conan-develop;conan user -p ${artifactory_pass} -r conan-develop admin;conan install App/1.0@mycompany/stable --profile conanio-gcc8 --build missing -r conan-develop;conan install App2/1.0@mycompany/stable --profile conanio-gcc8 --build missing -r conan-develop;conan upload '*' --all -r conan-develop --confirm  --force"
docker run --network="host" -it conanio/gcc7 /bin/bash -c "conan config install https://github.com/conan-ci-cd-training/settings.git;conan remote add conan-develop http://${address}:8081/artifactory/api/conan/conan-develop;conan user -p ${artifactory_pass} -r conan-develop admin;conan install App/1.0@mycompany/stable --profile conanio-gcc7 --build missing -r conan-develop;conan install App2/1.0@mycompany/stable --profile conanio-gcc7 --build missing -r conan-develop;conan upload '*' --all -r conan-develop --confirm  --force"

echo "------ Configure Jenkins jobs ------"

curl https://raw.githubusercontent.com/conan-ci-cd-training/conan_ci_cd/master/setup_jenkins/jenkins_jobs.tgz -O

tar -xvf jenkins_jobs.tgz --directory /var/lib/jenkins/jobs

echo "------ Restart Jenkins ------"

echo "--------------------------------"
echo "------ FINISHED BOOTSTRAP ------"
echo "--------------------------------"

curl -X POST -u administrator:${jenkins_pass} http://${address}:8080/restart