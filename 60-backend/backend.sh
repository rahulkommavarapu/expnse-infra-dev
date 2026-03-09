#!/bin/bash
# we need innstall the Ansible in this Server
dnf install ansible -y
#push Bases Request
# ansible-playbbok -i inventory mysql.yaml
 #to recive the Dev environment from main.tf
#pull
ansible-pull -i localhost -u https://github.com/rahulkommavarapu/Expense-Ansible-Roles.git main.yaml  -e COMPONENT=backend -e ENVIRONMENT=$1 # Ansible-pull take the backend.yaml from the Expense-Ansible-Roles  repo and Trigger it. 

