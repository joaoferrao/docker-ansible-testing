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

## Test your first command
From within the `control` container:
```bash
ssh-keygen  # Generate a new key and leave the defaults including no password.
ssh-copy-id remote-user@ec1  # You should be able to copy the key to the ec1 node
ansible all -m ping --user=remote-ansible  # should return a green success message.
```

#### Increase verbosity
The more `v`'s, the more vebose the commands.
```bash
ansible all -vvv -m ping --user=remote-ansible  # should return a green success message.
```

#### Copy the keys to all node containers
In the previous step, the key was copied to ec1, so only ec2 and ec3 are left.
```bash
for host in ec2, ec3; do ssh-copy-id remote-ansible@${host}; done
ansible all -m ping --user=remote-ansible -o
```


#### List hosts of a particular group from the inventory
```bash
ansible aws --list-hosts --user=remote-ansible  # only in th 'aws' group
ansible all --list-hosts --user=remote-ansible  # list all hosts
ansible ~.*3 --list-hosts --user=remote-ansible  # using POSIX to find with pattern
```



