#!/bin/bash

# bootstrap jenkins

# param 1: Artifactory password
# param 2: Jenkins administrator password

address="jfrog.local"
artifactory_pass=$1
jenkins_pass=$2

echo "Config git"

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

echo "Configure conan"

conan config install https://github.com/conan-ci-cd-training/settings.git

echo "Clone libraries"

mkdir /git_server && cd /git_server

git clone --bare https://github.com/conan-ci-cd-training/libA.git
git clone --bare https://github.com/conan-ci-cd-training/libB.git
git clone --bare https://github.com/conan-ci-cd-training/libC.git
git clone --bare https://github.com/conan-ci-cd-training/libD.git
git clone --bare https://github.com/conan-ci-cd-training/App.git
git clone --bare https://github.com/conan-ci-cd-training/App2.git
git clone --bare https://github.com/conan-ci-cd-training/products.git
git clone --bare https://github.com/conan-ci-cd-training/release.git

echo "curl http://${address}:8080/git/notifyCommit?url=/repos/libA.git" > /git_server/libA.git/hooks/post-receive
echo "curl http://${address}:8080/git/notifyCommit?url=/repos/libB.git" > /git_server/libB.git/hooks/post-receive
echo "curl http://${address}:8080/git/notifyCommit?url=/repos/libC.git" > /git_server/libC.git/hooks/post-receive
echo "curl http://${address}:8080/git/notifyCommit?url=/repos/libD.git" > /git_server/libD.git/hooks/post-receive
echo "curl http://${address}:8080/git/notifyCommit?url=/repos/App.git" > /git_server/App.git/hooks/post-receive
echo "curl http://${address}:8080/git/notifyCommit?url=/repos/App2.git" > /git_server/App2.git/hooks/post-receive
echo "curl http://${address}:8080/git/notifyCommit?url=/repos/products.git" > /git_server/products.git/hooks/post-receive
echo "curl http://${address}:8080/git/notifyCommit?url=/repos/release.git" > /git_server/release.git/hooks/post-receive

mkdir /bootstrap_repos && cd /bootstrap_repos

git clone /git_server/libA.git
git clone /git_server/libB.git
git clone /git_server/libC.git
git clone /git_server/libD.git
git clone /git_server/App.git
git clone /git_server/App2.git

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

conan upload '*' -r conan-develop --all --confirm

docker run --network="host" -it conanio/gcc6 /bin/bash -c "sudo mkdir /git_server && cd /git_server && sudo git clone --bare https://github.com/conan-ci-cd-training/libA.git && sudo git clone --bare https://github.com/conan-ci-cd-training/libB.git && sudo git clone --bare https://github.com/conan-ci-cd-training/libC.git && sudo git clone --bare https://github.com/conan-ci-cd-training/libD.git && sudo git clone --bare https://github.com/conan-ci-cd-training/App.git && sudo git clone --bare https://github.com/conan-ci-cd-training/App2.git && conan config install https://github.com/conan-ci-cd-training/settings.git;conan remote add conan-develop http://${address}:8081/artifactory/api/conan/conan-develop;conan user -p ${artifactory_pass} -r conan-develop admin;conan install App/1.0@mycompany/stable --profile debug-gcc6 --build missing -r conan-develop;conan install App2/1.0@mycompany/stable --profile debug-gcc6 --build missing -r conan-develop;conan upload '*' --all -r conan-develop --confirm"
docker run --network="host" -it conanio/gcc6 /bin/bash -c "sudo mkdir /git_server && cd /git_server && sudo git clone --bare https://github.com/conan-ci-cd-training/libA.git && sudo git clone --bare https://github.com/conan-ci-cd-training/libB.git && sudo git clone --bare https://github.com/conan-ci-cd-training/libC.git && sudo git clone --bare https://github.com/conan-ci-cd-training/libD.git && sudo git clone --bare https://github.com/conan-ci-cd-training/App.git && sudo git clone --bare https://github.com/conan-ci-cd-training/App2.git && conan config install https://github.com/conan-ci-cd-training/settings.git;conan remote add conan-develop http://${address}:8081/artifactory/api/conan/conan-develop;conan user -p ${artifactory_pass} -r conan-develop admin;conan install App/1.0@mycompany/stable --profile release-gcc6 --build missing -r conan-develop;conan install App2/1.0@mycompany/stable --profile release-gcc6 --build missing -r conan-develop;conan upload '*' --all -r conan-develop --confirm"

#echo "------ Configure Jenkins jobs ------"

rm -rf /var/lib/jenkins/jobs/maven-pipeline/
rm -rf /var/lib/jenkins/jobs/maven-promotion/

#curl https://raw.githubusercontent.com/conan-ci-cd-training/conan_ci_cd/master/setup_jenkins/jenkins_jobs.tgz -O

#tar -xvf jenkins_jobs.tgz --directory /var/lib/jenkins/jobs

echo "------ Restart Jenkins ------"

echo "--------------------------------"
echo "------ FINISHED BOOTSTRAP ------"
echo "--------------------------------"

#curl -X POST -u administrator:${jenkins_pass} http://${address}:8080/restart
