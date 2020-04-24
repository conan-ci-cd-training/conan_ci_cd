#!/bin/bash

## lab4: 

# upload the two generated packages for the new revisions of libB to conan-tmp

conan upload libB/1.0@mycompany/stable#a6c44191b4b5391c3678ae1d458375ec --all -r conan-tmp --confirm

conan search libB/1.0@mycompany/stable -r conan-tmp --revisions