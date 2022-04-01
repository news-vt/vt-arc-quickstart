# vt-arc-quickstart

Quickstart material for VT ARC HPC resources.

## Contents

- [SSH Configuration guide](#ssh-configuration): SSH configuration with ARC cluster node aliases (see also [ssh.config](ssh.config)).

## SSH Configuration

To prevent typing long login node addresses, it is recommended to use SSH configuration files to create aliases. This guide provides a starter file ([ssh.config](ssh.config)) that should meet the needs of most users. The steps to deploy this on your own machine are:

1. Make any desired changes to [ssh.config](ssh.config)
2. Copy this file to:
    - Linux/macOS: `${HOME}/.ssh/config`
    - Windows 10: `%HOMEPATH%/.ssh/config`


In terms of syntax, you can alias a host using the following example:
```sshconfig
# TinkerCliffs
host arc-tc
    hostname tinkercliffs1.arc.vt.edu
    #user <vt-pid>
```

To work interactively on a running cluster node, you must also define an alias to remotely tunnel through the login node. The following syntax example does this:
```sshconfig
# TinkerCliffs cluster nodes.
# Usage: ssh tc1234
host tc*
    hostname %h
    ProxyJump arc-tc
    #user <vt-pid>
```

__Note__: You can omit your VT PID from the config file, but it will require you to specify it during the ssh command.

Usage examples of the above are:
```bash
# SSH into TinkerCliffs login node 1.
# If PID is inside ssh/config
$ ssh arc-tc
# OR using PID manually
$ ssh <pid>@arc-tc
```

```bash
# SSH into TinkerCliffs cluster node 038.
# (note that a job must already be allocated to this node)
# If PID is inside ssh/config
$ ssh tc038
# OR using PID manually
$ ssh <pid>@tc038
```