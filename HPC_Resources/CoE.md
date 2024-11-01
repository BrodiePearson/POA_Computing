# Accessing and using HPC resources in [CoE](https://it.engineering.oregonstate.edu/hpc) (College of Engineering)

## Contributors: Brodie Pearson

Access this resource via the [HPC Dashboard](https://ondemand.hpc.engr.oregonstate.edu/) or through standard SSH [NOT WORKING]:

```shell
ssh [username]@submit-a.hpc.engr.oregonstate.edu
```

This resource can be used similar to the more extensive CQLS documentation page. But there is some specific CoE-specific information below.

## Using the ``preempt`` _partition_

A command like this will start an interactive session on a V100 which is suitable for Oceananigans simulations. The ``preempt`` partition allows users to request communal resources that are in low demand:

```shell
srun -p preempt --gres=gpu:1 --constraint=v100 --pty bash
```

So far we have had success running Oceananigans on the NVIDIA V100 GPU (see above constraint) and on the RTX6000 (replace with ``--constraint=rtx6000``)

## Advanced GPUs for future research

If GPUs are useful for your research going forward, you can also access the new _dgxs_ or _dgxh_ nodes via CEOAS or Engineering group (may need to replace ``dgxs`` with ``dgxh`` or ``dgx2`` depending on your group permissions), for example:

```shell
srun -p dgxs --gres=gpu:1 --mem=8G -t 00:10:00 -N 1 --pty /bin/bash
```

