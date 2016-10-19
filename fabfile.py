from fabric.api import local, warn_only

def prepare_dev_environment():
    local('ansible-playbook ansible/dev-environment.yml')
    ansible_install()

def ansible_install():
    with warn_only():
        local('sudo mkdir /etc/ansible')
    local('sudo ansible-galaxy install -r ansible/requirements.yml')

def deploy():
    local('ansible-playbook ansible/site.yml')

