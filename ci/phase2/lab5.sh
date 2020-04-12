#!/bin/bash

## lab5: 
conan remove "*" -f 
conan graph lock App/1.0@mycompany/stable --profile=release-gcc6 --lockfile=app_graph.lock -r=conan-develop
conan graph build-order app_graph.lock --json=build_order.json --build
grep -q "libB/1.0@mycompany/stable" app_graph.lock
echo $?
conan graph lock App2/1.0@mycompany/stable --profile=release-gcc6 --lockfile=app2_graph.lock -r=conan-develop
conan graph build-order app2_graph.lock --json=build_order.json --build
grep -q "libB/1.0@mycompany/stable" app2_graph.lock
echo $?