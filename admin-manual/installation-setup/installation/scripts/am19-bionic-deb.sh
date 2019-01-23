#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password your_password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password your_password'
sudo debconf-set-selections <<< "postfix postfix/mailname string your.hostname.com"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo debconf-set-selections <<< "archivematica-mcp-server archivematica-mcp-server/dbconfig-install boolean true"
sudo debconf-set-selections <<< "archivematica-mcp-server archivematica-mcp-server/mysql/app-pass password mcp_password"
sudo debconf-set-selections <<< "archivematica-mcp-server archivematica-mcp-server/app-password-confirm password mcp_password"



sudo wget -O - https://packages.archivematica.org/1.9.x/key.asc | sudo apt-key add -
sudo wget -O - http://jenkins-ci.archivematica.org/repos/devel.key | sudo apt-key add -
sudo sh -c 'echo "deb [trusted=yes] http://jenkins-ci.archivematica.org/repos/am-packbuild/1.9.0/bionic/ ./" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.9.x/ubuntu-externals bionic main" >> /etc/apt/sources.list'

sudo curl -s https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.6.deb -o /var/cache/apt/archives/elasticsearch-1.7.6.deb
sudo dpkg -i /var/cache/apt/archives/elasticsearch-1.7.6.deb

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get install -y htop ntp unzip openjdk-8-jre-headless

sudo apt-get install -y archivematica-storage-service

sudo rm -f /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/storage /etc/nginx/sites-enabled/storage

curl -Ls https://bootstrap.pypa.io/get-pip.py | sudo python -

sudo apt-get install -y archivematica-mcp-server
sudo apt-get install -y archivematica-dashboard
sudo apt-get install -y archivematica-mcp-client

sudo ln -s /etc/nginx/sites-available/dashboard.conf /etc/nginx/sites-enabled/dashboard.conf

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
          --superuser";


