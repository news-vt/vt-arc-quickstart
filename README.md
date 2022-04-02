# vt-arc-quickstart

Quickstart material for VT ARC HPC resources.

## Contents

- [Code Editor](#code-editor): Recommendations for code editors and plugins.
- [SSH Configuration guide](#ssh-configuration): SSH configuration with ARC cluster node aliases (see also [ssh.config](ssh.config)).

## Code Editor

A code editor is required for development. Many are available, use whichever you prefer. However, something to consider is using one that has remote development capabilities. `VSCode` is recommended for several reasons:
- Fast
- Lightweight
- Extensible through plugins
    - Jupyter notebooks
    - Remote development
- Widely used by developer community

You can download `VSCode` from its homepage: <https://code.visualstudio.com/>

### Recommended VSCode Extensions

If you choose `VSCode`, then a list of recommended extensions are:
- `ms-vscode-remote.vscode-remote-extensionpack` ([VS Marketplace Link](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack))
- `ms-python.python` ([VS Marketplace Link](https://marketplace.visualstudio.com/items?itemName=ms-python.python))
- `eamodio.gitlens` ([VS Marketplace Link](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens))


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