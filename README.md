# vt-arc-quickstart

Quickstart material for VT ARC HPC resources.

I wrote a tutorial presentation that provides more overview information on how ARC works, and how you as a developer can interact with it. You can find it on Google Drive at: <https://docs.google.com/presentation/d/1DP41pLniomDlMRpdZvensxEITcIijGKw3hu-2-16mak/edit?usp=sharing>

## Table of Contents

- [Helpful Resources](#helpful-resources): Collection of useful links to aid environment setup and development.
- [Code Editor](#code-editor): Recommendations for code editors and plugins.
- [SSH Configuration guide](#ssh-configuration): SSH configuration with ARC cluster node aliases (see also [ssh.config](ssh.config)).

## Helpful Resources

- Anaconda Homepage: https://www.anaconda.com/products/distribution
- NEWS@VT ARC Quickstart Repository: https://github.com/news-vt/vt-arc-quickstart
- ARC Homepage: https://arc.vt.edu/
- ARC Documentation: https://www.docs.arc.vt.edu/index.html
    - Infer cluster info: https://www.docs.arc.vt.edu/resources/compute/01infer.html
    - Partition info: https://www.docs.arc.vt.edu/resources/gpu.html
    - Storage info: https://www.docs.arc.vt.edu/resources/storage.html
    - Storage changes: https://www.docs.arc.vt.edu/resources/storage-changes-sp22.html
    - Computational resources: https://www.docs.arc.vt.edu/resources/compute.html
- ARC ColdFront: https://coldfront.arc.vt.edu/
- Jupyter Homepage: https://jupyter.org/
- Singularity
    - Quickstart: https://sylabs.io/guides/2.6/user-guide/quick_start.html
- SLURM
    - Quickstart: https://slurm.schedmd.com/quickstart.html
    - Tutorials: https://slurm.schedmd.com/tutorials.html
- VPN info: https://www.nis.vt.edu/ServicePortfolio/Network/RemoteAccess-VPN.html
- VSCode:
    - Homepage: https://code.visualstudio.com/
    - Extension installation guide: https://code.visualstudio.com/docs/editor/extension-marketplace
- VT Network Password info: https://onecampus.vt.edu/task/all/network-password-show

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