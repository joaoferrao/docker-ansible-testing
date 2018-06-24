# docker-ansible-testing

Create the containers within the `docker-compose.yml` and experiment Ansible execution from within the `control` container.

- `control` container has `ansible` user
- `ecX` containers based on `awslinux` image have `ansible-remote` user with `ansible-remote` as password.
- Pre defined inventory of hosts called "aws" with `ec1`, `ec2`, `ec3`.
- If you call `all` in ansible commands, it will run against all hosts in the inventory, even if no group is defined and 

```bash
docker-compose up --build -d
```

Now you can open an interactive session with the `control` container and fiddle arround with Ansible.
```bash
docker container exec -it control bash 
```

# Fleet basic setup
## Test your first command 
From within the `control` container:
```bash
ssh-keygen  # Generate a new key and leave the defaults including no password.
ssh-copy-id remote-user@ec1  # You should be able to copy the key to the ec1 node
ansible all -m ping  # should return a green success message.
```

## Setup the rest of the fleet
The more `v`'s, the more vebose the commands.
```bash
ansible all -vvv -m ping  # should return a green success message.
```

#### Copy the keys to all node containers
In the previous step, the key was copied to ec1, so only ec2 and ec3 are left.
```bash
for host in ec2, ec3; do ssh-copy-id remote-ansible@${host}; done
ansible all -m ping -o
```

#### List hosts of a particular group from the inventory
```bash
ansible aws --list-hosts  # only in th 'aws' group
ansible all --list-hosts  # list all hosts
ansible ~.*3 --list-hosts  # using POSIX to find with pattern
```

## Modules
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
Used for file, symlinks and directory manipulation. Changes to a file only work if the file exits.
- Sets attributes of files, symlinks and directories, or removes directories/files/symlinks
- Many other modules support the same options as the `file` module - including `copy`, `template` 
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
- The command will be processed through the shell, so variables like $HOME and operations like "<", ">", "|", ";" and "&" will not work (we can use the `shell` module if we need these features).
- The `command` is the default module, so we can ommit the -m
```bash
ansible all -m command -a 'hostname' -o
ansible all -a 'hostname' -o
ansible all -a 'id'  # check if the connection used is having root privileges
ansible all -a 'touch /tmp/test_copy_module creates=/tmp/test_copy_module'
ansible all -a 'rm /tmp/test_copy_module removes=/tmp/test_copy_module'
```

Create a file with 600 access on the remotes `aws` group and fetch it to the `control`. We could join the first and second step, but it's a good moment to appreciate the two different params touch and file for state argument.
```bash
ansible@64feb316c831:/$ ansible aws -m file -a 'path=/tmp/test_modules.txt state=touch'
ansible aws -m file -a 'state=file mode=600 path=/tmp/test_modules.txt'
ansible aws -m fetch -a 'src=/tmp/test_modules.txt dest=/tmp/test_modules.txt'  # will copy each to a newly created folder such as "dest": "/tmp/test_modules.txt/ec3/tmp/test_modules.txt",
```
 