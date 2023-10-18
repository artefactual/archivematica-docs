#!/bin/bash

set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< "postfix postfix/mailname string your.hostname.com"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo debconf-set-selections <<< "archivematica-mcp-server archivematica-mcp-server/dbconfig-install boolean true"
sudo debconf-set-selections <<< "archivematica-mcp-server archivematica-mcp-server/mysql/app-pass password demo"
sudo debconf-set-selections <<< "archivematica-mcp-server archivematica-mcp-server/app-password-confirm password demo"

sudo wget -O - https://packages.archivematica.org/1.15.x/key.asc | sudo apt-key add -

sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.15.x/ubuntu jammy main" > /etc/apt/sources.list.d/archivematica.list'
sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.15.x/ubuntu-externals jammy main" > /etc/apt/sources.list.d/archivematica-externals.list'

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get install -y openjdk-8-jre-headless mysql-server
sudo apt-get install -y elasticsearch

sudo mysql -e "DROP DATABASE IF EXISTS SS; CREATE DATABASE SS CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
sudo mysql -e "CREATE USER 'archivematica'@'localhost' IDENTIFIED BY 'demo';"
sudo mysql -e "GRANT ALL ON SS.* TO 'archivematica'@'localhost';"

sudo apt-get install -y archivematica-storage-service

sudo rm -f /etc/nginx/sites-enabled/default
sudo ln -sf /etc/nginx/sites-available/storage /etc/nginx/sites-enabled/storage

sudo apt-get install -y archivematica-mcp-server
sudo apt-get install -y archivematica-dashboard
sudo apt-get install -y archivematica-mcp-client

sudo ln -sf /etc/nginx/sites-available/dashboard.conf /etc/nginx/sites-enabled/dashboard.conf

sudo systemctl daemon-reload
sudo service elasticsearch restart
sudo systemctl enable elasticsearch

sudo service clamav-freshclam restart
sudo service clamav-daemon start
sudo service gearman-job-server restart
sudo service archivematica-mcp-server start
sudo service archivematica-mcp-client restart
sudo service archivematica-storage-service start
sudo service archivematica-dashboard restart
sudo service nginx restart
sudo systemctl enable fits-nailgun
sudo service fits-nailgun start

sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 8000/tcp
sudo ufw reload

sudo -u archivematica bash -c " \
    set -a -e -x
    source /etc/default/archivematica-storage-service || \
        source /etc/sysconfig/archivematica-storage-service \
            || (echo 'Environment file not found'; exit 1)
    cd /usr/lib/archivematica/storage-service
      /usr/share/archivematica/virtualenvs/archivematica-storage-service/bin/python manage.py create_user \
          --username=admin \
          --password=archivematica \
          --email="example@example.com" \
          --api-key="THIS_IS_THE_SS_APIKEY" \
          --superuser
";
