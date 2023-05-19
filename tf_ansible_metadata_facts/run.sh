#!/usr/bin/env bash

set -eux
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null'

# test ec2_instance_metadata
ansible-playbook metadata_facts_playbook.yml -i inventory.yaml \
    -e local_tmp=/tmp/ansible-local \
    -e remote_tmp=/tmp/ansible-remote \
    -vvv \
    "$@"