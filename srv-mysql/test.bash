#!/bin/bash

# load check_functions.
. ./check_functions.bash

# testing
check_docker_service mysql
check_tcp 3306