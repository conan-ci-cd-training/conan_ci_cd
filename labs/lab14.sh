#!/bin/bash

## lab14: 

jfrog rt c --interactive=false  --url=http://jfrog.local:8081/artifactory --user=admin --password=<PASSWORD> art7

jfrog rt ping

jfrog rt download --spec=filespec_build_info.json app1_build_info/ 

jfrog rt sp --spec=filespec_myrelease.json "version=1.0.0,1.0.1;status.1.0.0=released"