#!/bin/bash

## lab15: 

# with creds or access token
curl -u<USER>:<PASS> -XPOST -T promotion_info.json <ART_URL>/api/build/promote/<BUILD_NAME>/<BUILD_NUMBER> 

# with JFrog CLI  
jfrog rt bpr <BUILD_NAME> <BUILD_NAME> <TARGET_REPO> --status=”prod”  --comment=”finally released” --include-dependencies=false --copy=false