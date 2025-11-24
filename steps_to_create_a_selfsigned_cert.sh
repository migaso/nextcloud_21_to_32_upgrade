# steps to create a selfsigned certificate
# Created by MAG

cd /your/path/nextcloud

# copy files from nextcloud docker container
docker cp nexcloud_app_container:/etc/apache2 .

mkdir -p ./apache2/ssl
openssl req -x509 -nodes -days 1825 -newkey rsa:2048 -out ./apache2/ssl/server.crt -keyout ./apache2/ssl/server.key

# connect to container
docker exec -it nexcloud_app_container sh

# run next command
a2enmod ssl

# docker symlink
ln -s /etc/apache2/sites-available/default-ssl.conf ../sites-enabled/000-default-ssl.conf

# come back to your host and edit 000-default-ssl.conf
vim ./apache2/sites-enabled/000-default-ssl.conf

# look and change next values
SSLCertificateFile ./apache2/ssl/server.crt
SSLCertificateKeyFile ./apache2/ssl/server.key
# save file changes

# connect to container and restart service
service apache2 restart

# bounce docker services with compose.yaml to complete process
docker-compose down
docker-compase up