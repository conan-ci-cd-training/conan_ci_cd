#!/bin/bash

## lab13: 

# with creds or access token
$ curl -uadmin:<PASS> -XPOST -T artifact_search.json http//jfrog.local:8081/artifactory/api/search/aql 