#!/bin/bash

curdir=$(pwd)
RED='\033[0;51;30m'
STD='\033[0;0;39m'

lab2() {
    ./lab2.sh
}

lab3() {
    ./lab3.sh
}

lab4() {
    ./lab4.sh
}

lab5() {
    ./lab5.sh
}

lab6() {
    ./lab6.sh
}

lab7() {
    ./lab7.sh
}

lab8() {
    ./lab8.sh
}

lab9() {
    ./lab9.sh
}

lab10() {
    ./lab10.sh
}

lab11() {
    ./promotion/lab11.sh
}

lab12() {
    ./promotion/lab12.sh
}

lab13() {
    ./promotion/lab13.sh
}

lab14() {
    ./promotion/lab14.sh
}

lab15() {
    ./promotion/lab15.sh
}

run_option() {
    set -e

    case $1 in
         2) lab2 ;;
         3) lab3 ;;
         4) lab4 ;;
         5) lab5 ;;
         6) lab6 ;;
         7) lab7 ;;
         8) lab8 ;;
         9) lab9 ;;
         10) lab10 ;;
         11) lab11 ;;
         12) lab12 ;;
         13) lab13 ;;
         14) lab14 ;;
         15) lab15 ;;

         -1) exit 0 ;;
         *) echo -e "${RED}Not valid option! ${STD}" && sleep 2
    esac
}


# function to display menus
show_menu() {
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo " Automation Catch Up Menu "
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "============== Conan CI/CD Training ================="
    echo "2. Create the library in the CI using lockfiles"
    echo "3. Get the complete reference of the new libB"
    echo "4. Upload new libB to conan-tmp"
    echo "5. Check if App/App2 need to be rebuilt"
    echo "6. Build the graph using the lockfile"
    echo "7. Upload new packages to conan-develop"
    echo "8. Upload lockfile to conan-metadata"
    echo "9. Generate a Build Info for App"
    echo "10. Merge and publish a Build Info"
    echo "11. Configure the JFrog CLI"
    echo "12. Download App based on properties"
    echo "13. Create and upload a debian package"
    echo "14. Create a custom Build info"
    echo "15. Build Info Promotion"
    echo "-1. Exit"
}


if [[ $1 ]]
then
    run_option $1
else
    while true
    do
        show_menu
        cd ${curdir}
        echo -n "Enter choice: "
        read choice
        run_option $choice
    done
fi