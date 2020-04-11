#!/bin/bash

## lab4: 

# upload the two generated packages for the new revisions of libB to conan-tmp
conan upload libB/1.0@mycompany/stable --all -r conan-tmp --confirm  --force
