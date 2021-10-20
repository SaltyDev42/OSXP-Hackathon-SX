#cloud-config
##THIS THING UP HERE IS A SHEBANG??
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

prefer_fqdn_over_hostname: true
hostname: ${name}
fqdn: ${name}.${project}.${domain}

write_files:
  - content: ${privkey}
    encoding: base64
    permissions: 0440
    owner: 1000:root
    path: /tmp/id_ed25519
