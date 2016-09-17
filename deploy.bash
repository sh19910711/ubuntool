#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "Usage: bash deploy.bash <ssh-host>"
  exit 1
fi

# system files
tar cvf - $(git ls-files etc/) | ssh $1 'sudo tar -C / -xvf -'
# user files
pushd home; tar cvf - $(git ls-files) | ssh $1 'tar -xvf -'; popd
tar cvf - $(git ls-files webapp/) | ssh $1 'tar -xvf -'

# build webapp
ssh $1 'cd webapp/golang && go build -o app'

# restart servers
ssh $1 'sudo systemctl restart mysql'
ssh $1 'sudo systemctl restart supervisor'
