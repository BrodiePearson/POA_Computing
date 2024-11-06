# Setting up interactive Matlab (web browser) GUI on a remote system

## Install MATLAB kernel on remote machine
Follow instructions here: https://github.com/mathworks/jupyter-matlab-proxy

## Make sure Jupyter is in PATH
```
export PATH=~/miniconda3/bin:$PATH
```

## Start Jupyter session on remote machine:
```
jupyter lab --no-browser --port <port-number>
	(e.g., jupyter lab --no-browser --port 8080)
```

## Forward the port on the local machine
```
ssh -N -L localhost:<local-port>:localhost:<remote-port> <remote-user>@<remote-host>
```

Note: ssh may not give any text feedback after password, but you can open web browser and go to localhost:8080 at this point.

## Use “token” from Jupyter given on remote machine to log in

## If MATLAB kernel is installed, should be option in window to open MATLAB

##NOTE:
	Jesse has mentioned that many of these steps can be compressed by using jupyter-forward: https://github.com/ncar-xdev/jupyter-forward?tab=readme-ov-file

