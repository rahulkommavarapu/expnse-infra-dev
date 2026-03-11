#!/bin/bash
# install the Ansible
 dnf install ansible -y
 
#  push
#  ansible-playbook -i inventory mysql.yaml

# pull
ansible-pull -i localhost -U https://github.com/rahulkommavarapu225/Expense-Ansible-Roles-tf.git main.yaml -e component=backend -e environment=$1