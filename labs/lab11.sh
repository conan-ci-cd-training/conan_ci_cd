#!/bin/bash

## lab11: 

jfrog rt c --interactive=false  --url=http://jfrog.local:8081/artifactory --user=conan --password=conan2020 art7 

# show current art7 profile
jfrog rt c show

# ping doesn’t require authentication
jfrog rt ping
jfrog rt search conan-metadata/
