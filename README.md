# `dotfiles`

Sets up a new machine with my preferred environment configuration.

## Installation and Usage

> [!IMPORTANT]
> This script is intended to be run on a fresh install of Ubuntu 22.04 LTS. It will overwrite any existing configuration files.

All setup scripts use [Ansible](https://docs.ansible.com/). To set up Ansible, first update dependencies by running:

```bash
sudo apt update 
sudo apt install -y software-properties-common
```

Then, add the Ansible PPA and install Ansible:

```bash
sudo add-apt-repository -y --update ppa:ansible/ansible
sudo apt install -y ansible
```

With Ansible installed, install ansible scripts required dependencies:

```bash
ansible-playbook devtools/apt-packages.ansible.yml --ask-become-pass
ansible-galaxy install -r devtools/requirements.yml
```

Finally, run the setup script with Ansible:

```bash
ansible-playbook setup.ansible.yml --ask-become-pass
```
