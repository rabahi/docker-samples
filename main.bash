#!/bin/bash

# install required tools
sudo apt update && sudo apt install -y net-tools

# Clean everything
echo "clean everything"
#(docker system prune --all --volumes --force)

# List directories that contains docker-compose.yml
declare -a directories=($(ls -d */))

for i in "${!directories[@]}"; do
  # remove last slash
  directories[$i]="${directories[$i]%/}"
  
  directory="${directories[$i]}"  
  
  echo "###################"
  echo $directory
  echo "###################"  

  echo "start"
  (cd "$directory" && docker-compose up -d)

  echo "test installation"
  pwd
  sudo bash "$directory/test.bash" || { echo "Erreur dans $directory/test.bash"; exit 1; }

  echo "stop"
  (cd "$directory" && docker-compose down)
done
