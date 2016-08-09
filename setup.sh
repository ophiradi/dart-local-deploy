#!/usr/bin/env sh

# Start directory is tools/vagrant folder in dart repo (git clone https://github.com/RetailMeNotSandbox/dart.git)
set -x # echo command
set -e # exit on first error


## run unit-tests
python tests/test_generate_deployment_files.py

# We will read the code from this repo - you can change code and it will be seen in:
# Vagrant: /vagrant_Data
# Docker-containers: /Code
rm -rf ./dart
git clone https://github.com/RetailMeNotSandbox/dart.git 

# Generates Dokcer-compose, dockerfiles and config files from jinja templates.
python generate_deployment_files.py

# We build a VM (Using vagrant => vagrant up) that will have docker tools installed and other useful pre-reqs.
vagrant plugin install vagrant-triggers
vagrant plugin install vagrant-vbguest
vagrant up

## Launche docker-compose that launches dart-web, dart-postgresql and dart-elastic (elasticmq) as well as the trigger/subscription and engine workers.
vagrant ssh -c "~/additional_steps.sh"
