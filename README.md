# dart-local-deploy
Installs DART using docker-compose on a vagrant machine.  you can use Docker directly on your machine by following all the steps in Vagrantfile, VM_setup and additional_Steps.sh

See: https://github.com/RetailMeNotSandbox/dart

Prereqs: 
   -- pip and python installed
   -- Vagrant installation. 
   
Explanation of script's commands:
--------------------------------
0. (In tools/vagrant/docker/) python generate_deployment_files.py
  -- Generates Dokcer-compose, dockerfiles and config files from jinja templates.
  -- Any changes you wish to do to names/port will be done in generate_deployment_files.py (paramaters object)

1. vagrant up (folder with Vagrantfile)
  -- We build a VM (Using vagrant => vagrant up) that will have docker tools installed and other useful pre-reqs.

2. vagrant ssh
  -- We will install additional docker related pre-reqs (we do not do it in the vagrant script since after creating them docker group we need to logout/login), after 
     logging in to newly created VM.

3. ~/additional_steps.sh   
  -- The script launches docker-compose that launches dart-web, dart-postgresql and dart-elastic (elasticmq) as well as the trigger/subscription and engine workers.
  -- we also populate the local database and run the unit-tests.
     -- This step might fail and might need to be run manually (just copy paste from ~/additional_steps.sh)



Local-development:

1. The setup script git clones the repo to its local directory.
  -- It is the same repo that is mounted on the vagrant machine and mounted as a volume to all the (dart-workers) docker containers.
  -- You can edit the code in this repo and expect to see changes in UI.

2. If you need to relaunch a container.
   -- make sure you relaunch it with --build (e.g. in vagrant machine: cd /vagrant_data/docker_files; docker-compose up -d --build web)  
      - Sometime you need to rerun the server.py for the web worker.
   -- In cases where you changed the docker-compose files (e.g. volumes, ports ...)
      - Make sure to delete all docker images before rebuilding (docker images; docker rmi <image-id>) 


=== Troubleshooting ===

1. Make sure no other VM runs with the same name.

2. Make sure no other VM/pychram process holds a port - 5000 (5432, 9324)  

3. dart-postgres: AttributeError: 'ProjectError' object has no attribute 'msg' ==> A docker contianer already holds port 5432 (docker-compose ps)

4. When you want to rebuild a docker image with new files - make sure you 1. docker-compose kill, 2.docker-compose rm and docker rmi <image>. 
   - The do docker-compose up <name from docker-compose.yaml>
