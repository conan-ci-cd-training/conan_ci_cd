#!/bin/bash

## lab4: 

# upload the two generated packages for the new revisions of libB to conan-tmp

conan upload libB/1.0@mycompany/stable#e736204bc19388683c3c4de92b474f5c --all -r conan-tmp --confirm

conan search libB/1.0@mycompany/stable -r conan-tmp --revisions