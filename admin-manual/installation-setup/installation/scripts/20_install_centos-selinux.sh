# Allow Nginx to use ports 81 and 8001
sudo semanage port -m -t http_port_t -p tcp 81
sudo semanage port -a -t http_port_t -p tcp 8001
# Allow Nginx to connect the MySQL server and Gunicorn backends
sudo setsebool -P httpd_can_network_connect_db=1
sudo setsebool -P httpd_can_network_connect=1
# Allow Nginx to change system limits
sudo setsebool -P httpd_setrlimit 1
