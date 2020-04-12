#!/bin/bash

## lab12: 

# with creds or access token
curl -uadmin:<PASS> -XPOST -T build_info_artifacts.json http//jfrog.local:8081/artifactory/api/search/aql 