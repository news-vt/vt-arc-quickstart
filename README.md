# vt-arc-quickstart

Quickstart material for VT ARC HPC resources.

Further information on how ARC works, and how you as a developer can interact with it, is provided as a tutorial presentation located on Google Drive at: <https://docs.google.com/presentation/d/1AjcTkYjcYQT7SowSosWFemgBvjpWzVnl/edit?usp=sharing>

## Table of Contents

- [Helpful Resources](#helpful-resources): Collection of useful links to aid environment setup and development.
- [Code Editor](#code-editor): Recommendations for code editors and plugins.
- [SSH Configuration guide](#ssh-configuration): SSH configuration with ARC cluster node aliases (see also [ssh.config](ssh.config)).
- [SLURM Usage](#slurm-usage): Quick reference for SLURM commands.
    - [`sinfo`](#sinfo)
    - [`squeue`](#squeue)
    - [`srun`](#srun)
    - [`sbatch`](#sbatch)
    - [`scancel`](#scancel)

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

## SLURM Usage

### `sinfo`

List information for all partitions on the current cluster:

```bash
[acd1797@infer1 ~]$ sinfo
PARTITION     AVAIL  TIMELIMIT  NODES  STATE NODELIST
t4_normal_q*     up   infinite      5    mix inf[005-006,011-012,015]
t4_normal_q*     up   infinite     11   idle inf[001-004,007-010,013-014,016]
t4_dev_q         up   infinite      2   idle inf[017-018]
p100_normal_q    up   infinite      1  down* inf034
p100_normal_q    up   infinite      1  drain inf022
p100_normal_q    up   infinite     19    mix inf[021,023-031,033,035-036,038-041,048,057]
p100_normal_q    up   infinite      6  alloc inf[032,042-043,046,050,058]
p100_normal_q    up   infinite     11   idle inf[037,044-045,047,049,051-056]
p100_dev_q       up   infinite      2   idle inf[059-060]
v100_normal_q    up   infinite      1   drng inf069
v100_normal_q    up   infinite     17   idle inf[061-068,070-078]
v100_dev_q       up   infinite      1  drain inf079
v100_dev_q       up   infinite      1    mix inf080
```

### `squeue`

Show all jobs in the queue for the current cluster:

```bash
[acd1797@infer1 ~]$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             66099 v100_dev_     bash  sengalg  R       5:12      1 inf080
             65997 p100_norm 6h1k.gam  hmichel  R      34:41      1 inf050
             65930 p100_norm 2n4y.gam  hmichel  R      41:42      1 inf058
             65784 p100_norm      zip    iankh  R    2:58:26      1 inf040
             65782 t4_normal     BE_1 hajarzah  R    3:41:24      1 inf011
             65767 p100_norm    25_50    iankh  R   10:35:13      1 inf039
             65764 p100_norm    25_50    iankh  R   11:06:57      1 inf035
             65759 p100_norm    25_50    iankh  R   11:53:32      1 inf057
             65755 p100_norm    25_50    iankh  R   11:58:20      1 inf048
             65754 p100_norm    25_50    iankh  R   12:06:28      1 inf038
             65753 p100_norm    25_50    iankh  R   12:27:59      1 inf031
             65748 p100_norm    25_50    iankh  R   12:29:40      1 inf036
             65746 p100_norm    25_50    iankh  R   12:40:29      1 inf041
             65745 p100_norm    25_50    iankh  R   12:47:58      1 inf033
             65725 t4_normal     rocl   mwahed  R   19:53:58      1 inf012
             65589 p100_norm heat_sin ruhitsin  R 1-03:26:50      2 inf[042-043]
             65580 t4_normal  HIV_100   kbritt  R 1-15:37:03      1 inf006
             65392 t4_normal  HIV_100   kbritt  R 2-00:42:32      1 inf015
             65390 t4_normal  HIV_100   kbritt  R 2-00:58:59      1 inf005
             65286 v100_norm ttfe_tra juvekara  R 2-18:26:56      1 inf069
             64882 p100_norm mimi_new juliamon  R 4-21:14:01      1 inf030
             64881 p100_norm mimi_new juliamon  R 4-21:14:16      1 inf029
             64880 p100_norm mimi_new juliamon  R 4-21:14:25      1 inf028
             64875 p100_norm indo_new juliamon  R 4-21:27:28      1 inf026
             64874 p100_norm indo_new juliamon  R 4-21:30:04      1 inf025
             64868 p100_norm 7cv3_pru rfogarty  R 4-23:03:19      1 inf024
             64866 p100_norm 7cv3_pru rfogarty  R 4-23:11:58      1 inf023
             64862 p100_norm prod_tes juliamon  R 5-00:14:38      1 inf021
             64516 p100_norm    fx5-v mdawson2  R 9-09:57:12      1 inf027
             65601 p100_norm guppy_mo   cjchen  R   23:49:27      1 inf046
             65600 p100_norm guppy_mo   cjchen  R   23:49:34      1 inf032
```

Show jobs associated with a particular user on the current cluster:

```bash
[acd1797@infer1 ~]$ squeue -u acd1797
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
```

### `srun`

Run a synchronous interactive job on the current cluster using the following specs:
- Job is the `bash` shell
- `--pty`: Make job interactive. The term "pty" is an abbreviation for "pdeudoterminal".
- `--nodes=1`: 1 node
- `--gres=gpu:1`: 1 GPU
- `--account="bigdata"`: Use allocation with ID string `"bigdata"`
- `--partition=p100_normal_q`: Use partition with ID string `p100_normal_q`, which means Nvidia P100 GPU on the normal job queue
- `--ntasks 4`: Number of concurrent tasks within this job is 4
- `--cpus-per-task 4`: Number of cores per task is 4
- `--time=8:00:00`: Job run time until timeout is 8 hours

```bash
[acd1797@infer1 ~]$ srun --pty --nodes=1 --gres=gpu:1 --account="bigdata" --partition=p100_normal_q --ntasks 4 --cpus-per-task 4 --time=8:00:00 bash
```


### `sbatch`

Run an asynchronous job on the current cluster using details provided in a shell script file. To do this, first show the contents of the shell script:

```bash
[acd1797@infer1 vt-arc-quickstart]$ cat example_run_python_job.sh
#!/bin/bash
#SBATCH --job-name example_run_python_job
#SBATCH --partition=p100_normal_q
#SBATCH --nodes=1
#SBATCH --gres=gpu:2
#SBATCH --ntasks 4
#SBATCH --cpus-per-task 4
#SBATCH --time=12:00:00
#SBATCH --account="bigdata"
#SBATCH --mail-user=${USER}@vt.edu
#SBATCH --mail-type=BEGIN,END,FAIL

# Choose Anaconda environment name string.
CONDA_ENV_NAME="tf-p100"

# Load modules.
module reset
module load Anaconda3/2020.11

# Run python command using Anaconda enviroment.
conda run -n ${CONDA_ENV_NAME} python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
```

Then start the job using `sbatch` command:

```bash
[acd1797@infer1 vt-arc-quickstart]$ sbatch example_run_python_job.sh
Submitted batch job 66102
```

Get running job status via `squeue` command:
```bash
[acd1797@infer1 vt-arc-quickstart]$ squeue -u acd1797
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             66102 p100_norm example_  acd1797 CG       0:07      1 inf037
```

When the job finishes you can see the output via its log file:

```bash
[acd1797@infer1 vt-arc-quickstart]$ cat slurm-66102.out
Resetting modules to system default. Reseting $MODULEPATH back to system default. All extra directories will be removed from $MODULEPATH.
2022-04-11 12:13:37.859384: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcudart.so.10.1
2022-04-11 12:14:06.470160: I tensorflow/compiler/jit/xla_cpu_device.cc:41] Not creating XLA devices, tf_xla_enable_xla_devices not set
2022-04-11 12:14:06.472768: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcuda.so.1
2022-04-11 12:14:06.528755: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1720] Found device 0 with properties:
pciBusID: 0000:02:00.0 name: Tesla P100-PCIE-12GB computeCapability: 6.0
coreClock: 1.3285GHz coreCount: 56 deviceMemorySize: 11.91GiB deviceMemoryBandwidth: 511.41GiB/s
2022-04-11 12:14:06.530134: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1720] Found device 1 with properties:
pciBusID: 0000:82:00.0 name: Tesla P100-PCIE-12GB computeCapability: 6.0
coreClock: 1.3285GHz coreCount: 56 deviceMemorySize: 11.91GiB deviceMemoryBandwidth: 511.41GiB/s
2022-04-11 12:14:06.530175: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcudart.so.10.1
2022-04-11 12:14:06.737158: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcublas.so.10
2022-04-11 12:14:06.737265: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcublasLt.so.10
2022-04-11 12:14:07.006615: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcufft.so.10
2022-04-11 12:14:07.285658: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcurand.so.10
2022-04-11 12:14:07.407607: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcusolver.so.10
2022-04-11 12:14:07.621508: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcusparse.so.10
2022-04-11 12:14:07.898716: I tensorflow/stream_executor/platform/default/dso_loader.cc:49] Successfully opened dynamic library libcudnn.so.7
2022-04-11 12:14:07.905039: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1862] Adding visible gpu devices: 0, 1

[PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU'), PhysicalDevice(name='/physical_device:GPU:1', device_type='GPU')]
```


### `scancel`

Terminate a running job using job ID number:

```bash
[acd1797@infer1 vt-arc-quickstart]$ scancel 66102
```
