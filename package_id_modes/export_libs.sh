#!/bin/bash

echo "Export libraries"

conan export libA mycompany/stable
conan export libB mycompany/stable
conan export libC mycompany/stable
conan export App mycompany/stable