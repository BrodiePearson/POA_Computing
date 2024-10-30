# Using Visual Studio (VS) Code on HPC systems

VS Code is an integrated development environment which can be used to develop or edit code, and to run/debug the code. As part of this functionality, it can also be used to access, and run code on, HPC resources.
To access the HPC system in VS Code, add the _Remote Development_ extension then restart VS Code. Once VS Code is reopened, access the command pallette (``Cmd+Shift+p``) and type “connect to host” and select the ``Remote-SSH: Connect to Host…`` option. Then enter the command you would typically use to remote login without the ``ssh`` command or spaces. For example, for CQLS access, 

```shell
[username]@hpc.cqls.oregonstate,edu
```

A new VS Code window should then open and you will be prompted to enter your Password and complete Duo Login. Now you should have an active VS Code window that is hosted on the HPC system. You can expand the bottom bar to access the standard terminal for navigation, and use the file editing windows to work on and run code on the HPC system.
