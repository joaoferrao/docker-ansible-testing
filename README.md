# docker-ansible-testing

Create the containers within the `docker-compose.yml` and experiment Ansible
execution from within the `jenkins-ansible` container.

- `jenkins-ansible` container a user `jenkins`
- `ecX` containers based on `awslinux` image have user: `ansible-remote` with
password: `ansible-remote` as password.
- Pre defined inventory of hosts called "aws" with `ec1`, `ec2`, `ec3`.
- If you call `all` in ansible commands, it will run against all hosts in the
inventory, even if no group is defined and

## How to use this setup
- Whenever you run `ansible <command>` or `ansible-playbook <file>`, ansible
will use the `ansible.cfg` file in the working directory you are at the moment.
For this, I've setup a set of different sub directories within `/ansible`, each 
of them containing an `ansible.cfg` specific to the playbooks or commands I need
to test. This folder is mounted in /etc/ansible inside the jenkins-ansible container.
   
## Build the docker images
```bash
docker-compose up --build -d
```

# Fleet basic setup
## Test your first command 
From within the `control` container:

#### Copy the keys to all node containers
Copy the keys inside the container
```bash
rm ~/.ssh/known_hosts  # If it's not the first time running this docker-compose, it will complain about the key being different in the next line.
for host in ec1 ec2 ec3; do ssh-copy-id -i ~/.ssh/id_rsa remote-ansible@${host}; done
```

## Test Ansible setup
The more `v`'s, the more vebose the commands.
```bash
cd /etc/ansible/aws_create_users
ansible all -m ping  # should return a green success message and 2 failed.
```

#### List hosts of a particular group from the inventory
```bash
ansible aws --list-hosts  # only in th 'aws' group
ansible all --list-hosts  # list all hosts
ansible ~.*3 --list-hosts  # using POSIX to find with pattern
```


## Ansible Playbooks
Make sure you are running a bash shell inside the `control` container. If you
aren't, run: `docker container exec -it control bash`
Now, to run a playbook, go into one of the `/ansible/0X_test_folder` directories
(which have a different `ansible.cfg` file each) and run the ansible playbooks
from there:
```bash
cd /etc/ansible/aws_create_users/
ansible-playbook create_users.yml
```

## Ansible CLI and Modules
For modules we can check the `ansible-doc` command.
```bash
ansible-doc <module>
```

### Setup Module
Used for gathering facts when executing Playbooks.
```bash
ansible aws -m setup
```

### File Module
Used for file, symlinks and directory manipulation. Changes to a file only work
if the file exits.
- Sets attributes of files, symlinks and directories, or removes directories/files/symlinks
- Many other modules support the same options as the `file` module - including
`copy`, `template` 
- For windows targets use the `win_file` module instead
```bash
ansible all -m file -a 'path=/tmp/test state=touch'  # create a file in all hosts
ansible all -m file -a 'path=/tmp/test state=file mode=600'  # change the rights of the file to 600
ansible all -m file -a 'path=/tmp/test state=absent'  # remove a file, it if exists
```

### Copy Module
User for copying files, from the local or remote, to a location on the remote.
Alternatively, to get files from remote to control, use module `fetch`.
```bash
touch /tmp/x
ansible all -m copy -a 'src=/tmp/x dest=/tmp/x'  # copy from src magchine /tmp/x to all hosts
ansible all -m copy -a 'remote_src=yes src=/tmp/x dest=/tmp/y'  # from from a remote host to all other hosts
```

### Command Module
Used for executing remote commands.
- Is followed by a list of space-delimited arguments.
- The command will be processed through the shell, so variables like $HOME and
operations like "<", ">", "|", ";" and "&" will not work (we can use the `shell`
module if we need these features).
- The `command` is the default module, so we can omit the -m
```bash
ansible all -m command -a 'hostname' -o
ansible all -a 'hostname' -o
ansible all -a 'id'  # check if the connection used is having root privileges
ansible all -a 'touch /tmp/test_copy_module creates=/tmp/test_copy_module'
ansible all -a 'rm /tmp/test_copy_module removes=/tmp/test_copy_module'
```

Create a file with 600 access on the remotes `aws` group and fetch it to the
`control`. We could join the first and second step, but it's a good moment to
appreciate the two different params touch and file for state argument.
```bash
ansible@64feb316c831:/$ ansible aws -m file -a 'path=/tmp/test_modules.txt state=touch'
ansible aws -m file -a 'state=file mode=600 path=/tmp/test_modules.txt'
ansible aws -m fetch -a 'src=/tmp/test_modules.txt dest=/tmp/test_modules.txt'  # will copy each to a newly created folder such as "dest": "/tmp/test_modules.txt/ec3/tmp/test_modules.txt",
```

### Acknowledgement

Original `create_users` playbook from [msergiy87](https://github.com/msergiy87/ansible-create-users)

