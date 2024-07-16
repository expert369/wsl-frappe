#!/bin/bash

echo "# Set noninteractive and set mariadb password"

export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< 'mariadb-server-10.3 mysql-server/root_password password frappe'
sudo debconf-set-selections <<< 'mariadb-server-10.3 mysql-server/root_password_again password frappe'

sudo apt-get clean -y
sudo apt-get autoremove -y
sudo apt --fix-broken install -y
sudo dpkg --configure -a
sudo apt-get install -f
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install git python3-dev python-setuptools python3-pip python3-distutils redis-server -y
sudo apt install python3-venv -y
sudo apt-get update -y
sudo apt-get install xvfb libfontconfig -y
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb
sudo apt install ./wkhtmltox_0.12.6.1-2.jammy_amd64.deb -y
rm wkhtmltox_0.12.6.1-2.jammy_amd64.deb
sudo apt-get install mariadb-server mariadb-client -y
sudo apt install python3.10-venv -y

# Configure MariaDB
echo "# Configure MariaDB"
sudo cp mysql.conf /etc/mysql/my.cnf
sudo service mariadb restart
sudo mariadb -u root -pfrappe -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'frappe' WITH GRANT OPTION;"
sudo mariadb -u root -pfrappe -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'frappe' WITH GRANT OPTION;"
sudo mariadb -u root -pfrappe -e "FLUSH PRIVILEGES;"

sudo apt-get install -y curl
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

username=$USER
cd /home/$username
sudo pip3 install frappe-bench
sudo npm install -g yarn

# chmod -R o+rwx /home/$username

echo "## Bench initialize frappe version 13, 14 and 15"
bench init --verbose --frappe-path https://github.com/frappe/frappe --frappe-branch version-13 --python /usr/bin/python3.10 frappe-bench13
bench init --verbose --frappe-path https://github.com/frappe/frappe --frappe-branch version-14 --python /usr/bin/python3.10 frappe-bench14
bench init --verbose --frappe-path https://github.com/frappe/frappe --frappe-branch version-15 --python /usr/bin/python3.10 frappe-bench15

## DO NOT INSTALL ANY UNNECESSARY APPS TO AVOID LONG INSTALL TIME

## Create site1.localhost and set it as default
# Enable developer mode and some misc configs
# 13
echo "#######################"
echo "## Create site1.localhost:8000 and set it as default"
echo "#######################"
cd /home/$username/frappe-bench13
bench new-site site1.localhost --db-root-password frappe --admin-password frappe
bench use site1.localhost
bench enable-scheduler
bench set-config developer_mode 1
bench --site site1.localhost set-maintenance-mode off
bench config dns_multitenant on
./env/bin/pip3 install cython==0.29.21
./env/bin/pip3 install numpy
./env/bin/pip3 install numpy-financial
# Install ERPNext
echo "# Install ERPNext for Frappe Version 13"
bench get-app erpnext --branch version-13
bench install-app erpnext
./env/bin/pip3 install -e apps/erpnext/

#14
echo "#######################"
echo "## Create site1.localhost:8001 and set it as default"
echo "#######################"
cd /home/$username/frappe-bench14
bench new-site site1.localhost --db-root-password frappe --admin-password frappe
bench use site1.localhost
bench enable-scheduler
bench set-config developer_mode 1
bench --site site1.localhost set-maintenance-mode off
bench config dns_multitenant on
./env/bin/pip3 install cython==0.29.21
./env/bin/pip3 install numpy
./env/bin/pip3 install numpy-financial
# Install ERPNext
echo "# Install ERPNext for Frappe Version 14"
bench get-app erpnext --branch version-14
bench install-app erpnext
./env/bin/pip3 install -e apps/erpnext/

#15
echo "#######################"
echo "## Create site1.localhost:8002 and set it as default"
echo "#######################"
cd /home/$username/frappe-bench15
bench new-site site1.localhost --db-root-password frappe --admin-password frappe
bench use site1.localhost
bench enable-scheduler
bench set-config developer_mode 1
bench --site site1.localhost set-maintenance-mode off
bench config dns_multitenant on
./env/bin/pip3 install cython==0.29.21
./env/bin/pip3 install numpy
./env/bin/pip3 install numpy-financial
# Install ERPNext
echo "# Install ERPNext for Frappe Version 15"
bench get-app erpnext --branch version-15
bench install-app erpnext
./env/bin/pip3 install -e apps/erpnext/

# Fixes Redis warning about memory and cpu latency.
echo "# Fixes Redis warning about memory and cpu latency."
echo 'never' | sudo tee --append /sys/kernel/mm/transparent_hugepage/enabled

# Fixes redis warning about background saves
echo 'vm.overcommit_memory = 1' | sudo tee --append /etc/sysctl.conf
echo "# Fixes redis warning about background saves"
# set without restart
sudo sysctl vm.overcommit_memory=1

# Fixes redis issue with low backlog reservation
echo "# Fixes redis issue with low backlog reservation"
echo 'net.core.somaxconn = 511' | sudo tee --append /etc/sysctl.conf
# set without restart
sudo sysctl net.core.somaxconn=511

echo "#######################"
echo "### MariaDB password is 'frappe'"
echo "#######################"
