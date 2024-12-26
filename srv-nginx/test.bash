#!/bin/bash

# load check_functions.
. ../check_functions.bash

# testing
check_docker_service nginx:latest

check_tcp 80

check_web_function "nginx" "http://localhost"
