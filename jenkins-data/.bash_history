ll
ls
pwd
cd /home/jenkins/
ls -la
echo $HOME
ssh remote-ansible@ec1
for h in 1 2 3; do ssh-copy-id remote-ansible@ec${h}; done
for h in -i  1 2 3; do ssh-copy-id remote-ansible@ec${h}; done
exit
exit
ssh -i ~/.ssh/id_rsa remote-ansible@ec1
for h in 1 2 3; do ssh-copy-id -i ~/.ssh/id_rsa remote-ansible@ec${h}; done
cd ~/.ssh/
ls -la
exit
cd ~/
ls -la
cd .ssh/
ls -la
exit
ls
ls -l
cd ~/.ssh/
ls -la
ssh-copy-id -i ~/.ssh/id_rsa remote-ansible@ec1
ssh remote-ansible@ec1
exit
for host in ec1, ec2, ec3; do ssh-copy-id remote-ansible@${host}; done
ssh remote-ansible@ec1
rm ~/.ssh/known_hosts
for host in ec1, ec2, ec3; do ssh-copy-id remote-ansible@${host}; done
ansible all -m ping -o
cd cd ~/etc/ansible/
cd ~/etc/ansible/
ansible all -m ping  # should return a green success message and 2 failed.
ls -la
ls
cd /etc/ansible/
ls
cd aws_create_users/
ansible all -m ping  # should return a green success message and 2 failed.
vim ~/.ssh/ssh_config
ansible all -m ping  # should return a green success message and 2 failed.
vim ansible.cfg 
ansible all -m ping -i
ansible all -m ping -o
ansible all -m ping -o
ansible all -m ping -o
ansible all -m ping -o
ls -la
ansible aws -m ping
ansible aws -m ping
ansible aws -m ping
ansible aws -m ping
ssh-copy-id -i ~/.ssh/id_rsa remote-ansible@ec1
ansible aws -m ping
for host in ec1, ec2, ec3; do ssh-copy-id remote-ansible@${host}; done
for host in ec1, ec2, ec3; do ssh-copy-id -i ~/.ssh/id_rsa remote-ansible@${host}; done
ssh-copy-id remote-ansible@$ec1
ssh-copy-id remote-ansible@$ec2
ssh-copy-id remote-ansible@$ec3
ssh-copy-id remote-ansible@ec2
for host in ec1, ec2, ec3; do ssh-copy-id -i ~/.ssh/id_rsa remote-ansible@${host}; done
for host in ec1, ec2, ec3; do ssh-copy-id -i ~/.ssh/id_rsa remote-ansible@${host}; done
exit
rm ~/.ssh/known_hosts  # If it's not the first time running this docker-compose, it will complain about the key being different in the next line.
for host in ec1, ec2, ec3; do ssh-copy-id -i ~/.ssh/id_rsa remote-ansible@${host}; done
for host in ec1 ec2 ec3; do ssh-copy-id -i ~/.ssh/id_rsa remote-ansible@${host}; done
ansible aws -m ping
cd etc/ansible/
ansible aws -m ping
cd aws_create_users/
ansible aws -m ping
cd ~/.ssh/
ls -la
chmod 400 awsuser 
exit
ls -la
ssh -i ~/.ssh/awsuser awsuser@ec1
pwd
cd etc/ansible/
ls -la
cd aws_create_users/
ansible-playbook create_users.yml 
ansible-playbook create_users.yml 
ansible-playbook create_users.yml 
ansible-playbook create_users.yml 
ansible-playbook
ansible-playbook aws create_users.yml 
ansible-playbook create_users.yml 
ansible-playbook create_users.yml 
ansible-playbook create_users.yml 
ansible-playbook create_users.yml 
apt-get install docker
exit
