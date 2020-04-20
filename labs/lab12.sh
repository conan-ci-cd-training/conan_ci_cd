#!/bin/bash

## lab12: 

# AQL will return the PREV containing the conan_package.tgz
cat automation/query.aql 
prev=$(jfrog rt curl -XPOST api/search/aql -T automation/query.aql | grep path | cut -d\" -f4) && echo $prev

sed "s#PATH#${prev}#" automation/filespec_tpl.json > filespec.json &&
cat filespec.json

# download conan_package.tgz from build info + extract content into folders
jfrog rt download --spec=filespec.json && ls -l conan_package.tgz
