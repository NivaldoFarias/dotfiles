# `dotfiles`

Scaffolds a development enviroment with my preferred configuration.

## Installation and Usage

> [!IMPORTANT]
> This script is intended to be run on a fresh install of Ubuntu 22.04 LTS [(Jammy Jellyfish)](https://releases.ubuntu.com/jammy/). It will overwrite any existing configuration files.

All setup scripts use [Ansible](https://docs.ansible.com/). To set up Ansible, first update dependencies:

```bash
sudo apt update 
sudo apt install -y software-properties-common
```

Then, add the Ansible PPA and install Ansible:

```bash
sudo add-apt-repository -y --update ppa:ansible/ansible
sudo apt install -y ansible
```

With Ansible installed, install Ansible scripts required dependencies:

```bash
ansible-galaxy install -r requirements.yml
```

Finally, run the setup script with Ansible:

```bash
ansible-playbook setup.ansible.yml --ask-become-pass
```

## Development

The only requirement for development for this project is [Ansible Lint](https://ansible.readthedocs.io/projects/lint/).

To setup the development enviroment, we'll need a Python virtual environment. To create one, run the following commands:

```bash
python3 -m venv .venv
source venv/bin/activate
``` 

Then, install the required dependencies:

```bash
pip install -r requirements-dev.txt
```