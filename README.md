# `dotfiles`

Sets up a new machine with my preferred environment configuration.

## Installation and Usage

> [!IMPORTANT]
> This script is intended to be run on a fresh install of Ubuntu 22.04 LTS. It will overwrite any existing configuration files.

All setup scripts use [Ansible](https://docs.ansible.com/). To set up Ansible, first update dependencies by running:

```bash
sudo apt update
sudo apt install software-properties-common
```

Then, add the Ansible PPA and install Ansible:

```bash
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

Finally, run the setup script with Ansible:

```bash
ansible-playbook setup.ansible.yml --ask-become-pass
```
