# Add
- generate ssh key before create a new compute instance (from local machine)
- ssh-keygen -t rsa -f gcp -C datacourses -b 2048 
- name: gcp
- user: datacourses
- add .public key to metadata of VMs
- add key for VM (airflow/kafka)

# add & configure ssh key into VM via terminal (Bash Terminal)
- ssh -i ~/.ssh/name of private key Name of Vms@External IP of VMs
- ssh -i ~/.ssh/gcp datacourses@External IP of VMs
- htop: able ssh to VMs (view VMs)
- touch ~/.ssh/config
- code ~/.ssh/config
- config to access VMs
- Host ABC
    HostName
    User
    IdentityFile
- connecting to VMs 
- ssh ABC 


# Install prerequisites for VMs
- update
sudo apt-get update
- Anacoda
bash: wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh

- Docker/docker-compose

# Need to start connecting with Vms
- ssh -i ./gcp datacourses@