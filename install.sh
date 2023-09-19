#!/usr/bin/env bash
#Are you root?
if [ "$USER" != root ]; then
  printf "Script must run with root privileges \n"
  exit 255
fi

#Adapt some sysctl setting on the host machine
sysctl net.ipv4.ip_unprivileged_port_start=80
sysctl fs.inotify.max_user_instances=4096