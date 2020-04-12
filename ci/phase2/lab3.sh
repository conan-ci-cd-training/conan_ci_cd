#!/bin/bash

## lab3: 

# get conan package <name> and <version>
conan inspect ../phase1/libB --raw name 
conan inspect ../phase1/libB --raw version
# search with --revisions to get the newly created revision (remember only one revision in the local cache)
conan search libB/1.0@mycompany/stable --revisions --raw --json=output.json
cat output.json