# Offsite Data Backup in 5 steps (Jesse Cusack)

### Goal: backup laptop or moderately large storage (up to several TB)

Good practice is to follow the 3, 2, 1 backup rule
* 3 copies of your files
* 2 copies on different media (off-site laptop SSD and external USB or NAS)
* 1 copy off site (off-site in the cloud)


**These slides are about creating an off-site copy using cloud storage. 
I use the terminal commands, but GUIs do exist for some tools (_kopia_).**

## Step 1

### Accept that _Box_ (or _OneDrive_) is our solution, providing unlimited "permanent" storage

## Step 2

### Install [rclone](https://rclone.org/) and [kopia](https://kopia.io/) to the computer that you will back up. 

This can be done for example on Macs with ``homebrew`` package manager:

```shell
brew install kopia
brew install rclone
```

_rclone_ is a tool for interacting with cloud storage (Uploading / downloading / deleting / syncing / copying / listing files etc) 

_kopia_ is a tool for managing backup snapshots (tracks changes in directories, uploads changes in an efficient way, can restore files / folders to snapshots). An alternative to ``kopia`` is [rustic](https://rustic.cli.rs/).

## Step 3

### Give _rclone_ to access your _Box_ storage (configure your remote)

Follow the instructions on the [rclone website](rclone.org/box/ (not as bad as it looks because you just enter yes for most steps)

In the following we assume you create a remote called ``box``

## Step 4

### Create a backup respository on _Box_

Create a folder in _Box_ where you want to store backups, e.g.
	
```shell
rclone mkdir box:my_backups
```

Then configure the folder as a _kopia_ repository

```shell
kopia repository create rclone --remote-path=box:my_backups
```

## Step 5

### Perform and schedule backups

Perform a single backup:
	
```shell
kopia snapshot create /path/to/directory
```

and schedule the backups using _cron_ (linux, mac), e.g., :

<img width="535" alt="image" src="https://github.com/user-attachments/assets/ea93dd94-1b3b-4f44-a0dd-89364d07151f">


## Restoring Data (if needed)

You can view available snapshots with 

```shell
kopia snapshot list
```

Then you can restore individual files and folders

```shell
kopia restore kffbb7c28ea6c34d6cbe555d1cf80faa9/subdir1/subdir2 sd2
```

You can also mount snapshots to view contents 


```shell
mkdir ~/mnt
kopia mount kb9a8420bf6b8ea280d6637ad1adbd4c5 ~/mnt
ls ~/mnt
umount ~/mnt
```

## Efficient Usage Tips

* Choose specific directories to backup
* Restore can be slow (alternative on-site backup are still preferred)
* Set a reasonable retention policy e.g. 6 hourly, 7 daily, 4 weekly, 12 monthly, 2 yearly, to save space.
* Careful with cron if you travel or use your phone as a hotspot, it could eat all your data. Might want to restrict backups to certain wifi networks. 








