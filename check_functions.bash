#!/bin/bash

echo
echo "##############################################"
echo "############## TEST INSTALLATION #############"
echo "##############################################"
echo

##################################################
#      PRIVATE FUNCTIONS 
##################################################

echo_success() {
  local message="$1"
  echo -e "\e[32m : [OK]\e[0m $message"
}

echo_failure() {
  local message="$1"
  echo -e "\e[31m : [FAILED]\e[0m $message"
}


# private function
# usage check title command
# example check "checking ls" ls
function check
{
  local title=$1
  local command=$2
  
  echo -n "$title"
  eval "$command > /dev/null 2>&1"
  RETVAL=$?
  if [ $RETVAL -eq 0 ]
  then echo_success
  else echo_failure
  fi
  echo
}

##################################################
#      CHECK FUNCTIONS
##################################################

# Check if tcp port is open
# usage: check_tcp myPort
# example check_tcp 80
function check_tcp()
{
  local port=$1
  title="Checking tcp port $port"
  command="netstat -nap | grep :$port"
  check "$title" "$command"
}


# Check if docker service is running
# usage: check_docker_service myService
# example check_docker_service httpd
function check_docker_service()
{
  local service=$1
  title="Checking docker service $service"
  #command="pgrep '$service'"
  command="docker ps | grep -q '$service'"
  check "$title" "$command"
}