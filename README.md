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
Go to the directory of frappe-bench
```
cd frappe-bench15
bench start
```
Next Step is to create new Project. First we need to create a new-site and new-app

Step 1 - Create a site in Frappe Bench
```
bench new-site pejay.com
```
Set the default site
```
bench use pejay.com
```

Step 2 - Install ERPNext latest version in bench & site
```
bench get-app erpnext
bench --site pejay.com install-app erpnext
bench start
```

Step 3 - Create and Install a Custom App
```
bench new-app custom_app_name
bench --site my-site.local install-app custom_app_name
```

Step 4 - Start the bench
```
bench start
```

## Credentials
MariaDB
frappe

## Ports
Frappe Bench v13 port - 8000 (site1.localhost:8000)
Frappe Bench v14 port - 8001 (site1.localhost:8001)
Frappe Bench v15 port - 8002 (site1.localhost:8002)
