# docker-ansible-testing

Create the containers within the `docker-compose.yml` and experiment Ansible execution from within the `control` container.


```bash
ANSIBLE_CONFIG=$(pwd)/ansible/ansible.cfg
docker-compose up --build -d
```

Now you can open an interactive session with the `control` container and fiddle arround with Ansible.
```bash
docker container exec -it control bash 
```