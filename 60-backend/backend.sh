#!/bin/bash
# ENVIRONMENT=$1
dnf install ansible -y
  
# pull
ansible-pull -i localhost, -U https://github.com/rahulkommavarapu/Expense-Ansible-Roles-tf.git main.yaml -e COMPONENT=backend -e ENVIRONMENT=$1