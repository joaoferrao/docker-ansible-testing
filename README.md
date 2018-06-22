# docker-ansible-testing

```{bash}
conda create -n test-ansible python=3.6
conda activate test-ansible
pip install -r requirements.txt
ANSIBLE_CONFIG=$(pwd)/ansible/ansible.cfg
docker-compose up --build -d
```