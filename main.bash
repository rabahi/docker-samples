#!/bin/bash

# install required tools
#sudo apt update && sudo apt install -y net-tools wget

# Clean everything
echo "clean everything"
#(docker system prune --all --volumes --force)

declare -a currentFolder=($(pwd))
echo "currentFolder : $currentFolder"

# List directories that contains docker-compose.yml
declare -a directories=($(ls -d */))

for i in "${!directories[@]}"; do
  # remove last slash
  directories[$i]="${directories[$i]%/}"
  
  directory="${directories[$i]}"

  echo
  echo "###################"
  echo $directory
  echo "###################"

  cd $currentFolder
  cd $directory

  echo "> start"
  docker-compose up -d --remove-orphans

  echo "> test installation"
  bash test.bash || { echo "Error when running test.bash"; exit 1; }

  echo "> stop"
  docker-compose down -v --remove-orphans
done
