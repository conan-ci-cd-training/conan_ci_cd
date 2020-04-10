
# Exercise

git clone https://github.com/conan-ci-cd-training/libB.git
cd libB
git checkout feature/add_comments

# want to build with several profiles
# debug
conan graph lock . --lockfile=../lockfiles/debug.lock -r conan-develop --profile debug-gcc6  
conan create . mycompany/stable --lockfile=../lockfiles/debug.lock -r conan-develop --profile debug-gcc6 

#release
conan graph lock . --lockfile=../lockfiles/release.lock -r conan-develop --profile release-gcc6  
conan create . mycompany/stable --lockfile=../lockfiles/release.lock -r conan-develop --profile release-gcc6 
