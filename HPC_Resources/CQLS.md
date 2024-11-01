# Accessing and using HPC resources through [CQLS](https://shell.cqls.oregonstate.edu/) (Center for Quantitive and Life Sciences) 

## Contributors: Brodie Pearson & Ara Lee

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


## Submitting a job to a specific node

```console
qsub run_script.sh
```

where ``run_script.sh`` is a file containing (with your username) a script to query the _ewg_ node's GPU status (``nvidia-smi``) and _julia_ version, and then submit the simulation in file ``test/test_sim.jl``. The submission also keeps track of the start time, end time, and exuction time of the job. This script is likely more complex than scripts you would create, as we needed to specify internet access (``http_proxy`` and ``https_proxy`` commands and specific _julia_ paths for this node's architecture.  

```bash
#!/bin/bash
#SBATCH --job-name=name
#SBATCH --output output.out
#SBATCH --partition=ewg
#SBATCH --nodelist=ewg

START=$(date +%s.%N)
echo "  Started on:           " `/bin/hostname -s` 
echo "  Started at:           " `/bin/date` 
echo "--------------------------------------------" 

export http_proxy=http://proxy-internal.ceoas.oregonstate.edu:3128
export https_proxy=http://proxy-internal.ceoas.oregonstate.edu:3128

# Set the PATH to the specific Julia version
# julia-1.8.5
# export PATH=/local/cluster/julia-1.8.5/bin:$PATH
# export LD_LIBRARY_PATH=/local/cluster/julia-1.8.5/lib:$LD_LIBRARY_PATH
# export CPATH=/local/cluster/julia-1.8.5/include:$CPATH

# # julia-1.10.1
# export PATH=/local/cluster/bin:$PATH
# export LD_LIBRARY_PATH=/local/cluster/lib:$LD_LIBRARY_PATH
# export CPATH=/local/cluster/include:$CPATH

# # julia-1.10.5
export PATH="/fs1/local/cqls/software/x86_64/julia-1.10.5/envs/julia/bin:$PATH"
export LD_LIBRARY_PATH="/fs1/local/cqls/software/x86_64/julia-1.10.5/envs/julia/lib:$LD_LIBRARY_PATH"

nvidia-smi
julia --version # checking Julia version
julia test/test_sim.jl 

echo "" 
echo "--------------------------------------------" 
echo "  Finished at:          " `date` 
END=$(date +%s.%N)

DIFF=$(echo "$END - $START" | bc)
HOURS=$(echo "scale=2; $DIFF / 3600" | bc)  
echo "  Execution time:        $HOURS hours"
```



