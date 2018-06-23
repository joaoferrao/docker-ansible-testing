# docker-ansible-testing

Create the containers within the `docker-compose.yml` and experiment Ansible execution from within the `control` container.

- `control` container has `ansible` user
- `ecX` containers based on `awslinux` image have `ansible-remote` user with `ansible-remote` as password.

```bash
ANSIBLE_CONFIG=$(pwd)/ansible/ansible.cfg
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
ansible all -m ping  # should return a green success message.
```