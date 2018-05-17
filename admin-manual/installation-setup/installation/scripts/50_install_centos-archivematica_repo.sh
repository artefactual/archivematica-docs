sudo -u root bash -c 'cat << EOF > /etc/yum.repos.d/archivematica.repo
[archivematica]
name=archivematica
baseurl=https://packages.archivematica.org/1.7.x/centos
gpgcheck=1
gpgkey=https://packages.archivematica.org/1.7.x/key.asc
enabled=1
EOF'

sudo -u root bash -c 'cat << EOF > /etc/yum.repos.d/archivematica-extras.repo
[archivematica-extras]
name=archivematica-extras
baseurl=https://packages.archivematica.org/1.7.x/centos-extras
gpgcheck=1
gpgkey=https://packages.archivematica.org/1.7.x/key.asc
enabled=1
EOF'
