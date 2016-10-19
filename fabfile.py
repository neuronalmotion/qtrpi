from fabric.api import local

def ansible_install():
    local('sudo ansible-galaxy install -r ansible/requirements.yml')

def deploy():
    local('ansible-playbook ansible/site.yml')

