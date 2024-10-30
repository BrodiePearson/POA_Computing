# Accessing and using HPC resources through [CQLS](https://shell.cqls.oregonstate.edu/) (Center for Quantitive and Life Sciences)

To login use the following terminal command with your ONID username, and follow the resulting prompts

```console
ssh [username]@hpc.cqls.oregonstate.edu
```

## Viewing node details & logging into a node

Now you are logged into the [CQLS](https://shell.cqls.oregonstate.edu/) cluster, you can use

```console
sinfo
``` 

To see a list of nodes and their use (or idle) status. You can use 

```console
scontrol show nodes [optional node name]
```

to see more detail about a specific node.

Once you know which node you want to use, write a command like the one below to login into a specific node interactively (in this case ``youmu`` which is a Grace-Hopper Superchip with 72 CPUs and a GH200 GPU)

```console
srun -n 1 -N 1 -w youmu -p ceoas-arm --propagate=NONE --pty /bin/bash
```

You should now be in an interactive session on the ``youmu`` node. If you are interested in utilizing GPUs, you can use 

```console
nvidia-smi
```

to get information about the GPU(s) available on the node, and their current usage. 

## Opening software on a node (Interactive session via command line)
You can open specific software by typing, for example, ``python``. Note that for ``julia`` usage on the Grace-Hoppers, you must type two extra commands prior to opening ``julia`` due to the need for specific drivers for the GH200’s novel architecture:

```console
export PATH="/local/cluster/CEOAS/aarch64/opt/julia/julia-1.10.0/bin:${PATH}"
export LD_LIBRARY_PATH=/local/cluster/CEOAS/aarch64/opt/julia/julia-1.10.0/lib
```


## Submitting a job to a specific node (DOES NOT WORK CURRENTLY)

```console
qsub test_gpu_nvidia_smi.sh
```

where ``test_gpu_nvidia_smi.sh`` is a file containing (with your username) a script to submit a job in file ``test_gpu_nvidia_smi``

```bash
#!/bin/bash -l
#SBATCH -J test_gpu_nvidia_smi
#SBATCH -o test.output
#SBATCH -e test.output
#SBATCH -t 0:1:0
#SBATCH --nodelist=ewg
#SBATCH --account=[username]@oregonstate.edu
#SBATCH --mem=4000
nvidia-smi
```



