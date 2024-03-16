#!/bin/bash
sudo apt update -y
sudo apta-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
