#!/bin/bash

# load check_functions.
. ../check_functions.bash

# testing mysql
check_docker_service mysql:5.7
check_tcp 3306
check_docker_exec srv-mysql_service-mysql_1 'mysql --user=root --password=root --host=localhost sampledb -e "SHOW DATABASES;"'

# testing phpmyadmin
check_docker_service phpmyadmin/phpmyadmin
check_tcp 80
check_web_function phpMyAdmin "http://localhost"

