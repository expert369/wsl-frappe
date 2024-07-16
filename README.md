# Windows Subsystem for Linux(WSL) for Frappe
This contains a script that initializes frappe version 13, 14 and 15 and dependencies

## Setup WSL
Open a terminal and enter the command.
```
wsl --install
```
This will install Ubuntu in your WSL.
Restart when prompted.

Open terminal and enter the command.
```
ubuntu
```
Enter a username when prompted.
Enter a password when prompted.

## Install frappe installation script
Clone the script.
```
git clone https://github.com/iaiaian1/wsl-frappe
```
```
cd wsl-frappe
```
```
bash ./install.sh
```
enter WSL password when prompted

## To exit/open the WSL
Open a terminal and enter the command for shutdown.
```
wsl --shutdown
```
Run this command to turn the WSL again.
```
ubuntu
```

## Credentials
MariaDB
frappe

## Ports
Frappe Bench v13 port - 8000 (site1.localhost:8000)
Frappe Bench v14 port - 8001 (site1.localhost:8001)
Frappe Bench v15 port - 8002 (site1.localhost:8002)