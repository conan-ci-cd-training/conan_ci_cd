#!/bin/bash

# bootstrap jenkins

# param 1: Orbitera IP
# param 2: Artifactory password
# param 3: Jenkins administrator password

echo "Clone libraries"

cd /var/lib/jenkins

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

git clone https://github.com/conan-ci-cd-training/libA.git
git clone https://github.com/conan-ci-cd-training/libB.git
git clone https://github.com/conan-ci-cd-training/libC.git
git clone https://github.com/conan-ci-cd-training/App.git
git clone https://github.com/conan-ci-cd-training/App2.git
git clone https://github.com/conan-ci-cd-training/products.git

conan export libA mycompany/stable
conan export libB mycompany/stable
conan export libC mycompany/stable
conan export App mycompany/stable
conan export App2 mycompany/stable

conan remote add conan-develop http://$1:8081/artifactory/api/conan/conan-develop
conan remote add conan-tmp http://$1:8081/artifactory/api/conan/conan-tmp
conan user -p $2 -r conan-develop admin
conan user -p $2 -r conan-tmp admin

conan upload '*' -r conan-tmp --confirm  --force
conan upload '*' -r conan-develop --confirm  --force

docker run -it conanio/gcc8 /bin/bash  -c "conan config install https://github.com/conan-ci-cd-training/settings.git;conan remote add conan-develop http://$1:8081/artifactory/api/conan/conan-develop;conan remote add conan-tmp http://$1:8081/artifactory/api/conan/conan-tmp;conan user -p $2 -r conan-develop admin;conan user -p $2 -r conan-tmp admin;conan install App/1.0@mycompany/stable --profile conanio-gcc8 --build missing -r conan-tmp;conan install App2/1.0@mycompany/stable --profile conanio-gcc8 --build missing -r conan-tmp;conan upload '*' --all -r conan-tmp --confirm  --force;conan upload '*' --all -r conan-develop --confirm  --force"
docker run -it conanio/gcc7 /bin/bash  -c "conan config install https://github.com/conan-ci-cd-training/settings.git;conan remote add conan-develop http://$1:8081/artifactory/api/conan/conan-develop;conan remote add conan-tmp http://$1:8081/artifactory/api/conan/conan-tmp;conan user -p $2 -r conan-develop admin;conan user -p $2 -r conan-tmp admin;conan install App/1.0@mycompany/stable --profile conanio-gcc7 --build missing -r conan-tmp;conan install App2/1.0@mycompany/stable --profile conanio-gcc7 --build missing -r conan-tmp;conan upload '*' --all -r conan-tmp --confirm  --force;conan upload '*' --all -r conan-develop --confirm  --force"

curl https://raw.githubusercontent.com/conan-ci-cd-training/conan_ci_cd/master/setup_jenkins/jenkins_jobs.tgz -O

tar -xvf jenkins_jobs.tgz --directory /var/lib/jenkins/jobs

curl -X POST -u administrator:$3 http://$1:8080/restart