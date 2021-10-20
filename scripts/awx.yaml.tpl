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
    groups: users, wheel, root
    lock_passwd: false
    ssh_authorized_keys:
      - ${pubkey}

prefer_fqdn_over_hostname: true
hostname: ${name}
fqdn: ${name}.${project}.${domain}

runcmd:
  - "sudo yum install python3 -y"
  - "sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo"
  - "sudo yum install docker-ce -y"
  - "sudo pip3 install --upgrade pip"
  - "sudo pip3 install docker-compose"
  - "systemctl enable --now docker"
  - "alternatives --install /usr/bin/docker-compose docker-compose /usr/local/bin/docker-compose 100"
