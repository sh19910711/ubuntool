#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "ERR: set target host"
  echo "USG: ./init.sh <host>"
else
  ssh $1 "sudo apt update && sudo apt install -y python"
fi
