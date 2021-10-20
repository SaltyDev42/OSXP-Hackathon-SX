#cloud-config
## THIS THING UP HERE IS A SHEBANG?
groups:
  - ${name}

# Add users to the system. Users are added after groups are added.
users:
  - default
  - name: ${name}
    gecos: ${name}
    shell: /bin/bash
    primary_group: ${name}
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, wheel
    lock_passwd: false
    ssh_authorized_keys:
      - ${pubkey}

yum_repos:
  docker-ce-stable:
    name: Docker CE Stable - $basesearch
    baseurl: https://download.docker.com/linux/centos/$releasever/$basearch/stable
    enabled: 1
    gpgcheck: 1
    gpgkey: https://download.docker.com/linux/centos/gpg

prefer_fqdn_over_hostname: true
hostname: ${name}
fqdn: ${name}.${project}.${domain}

packages:
  - epel-release
  - centos-release-ansible-29
  - ansible
  - python3
  - python3-pip
  - docker-ce
  - git
