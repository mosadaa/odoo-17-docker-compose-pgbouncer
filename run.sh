#!/bin/bash
DESTINATION=$1
PORT=$2
CHAT=$3

# Clone Odoo directory
git clone --depth=1 https://github.com/mosadaa/odoo-17# Installing Odoo 17.0 with one command (Supports multiple Odoo instances on one server).

## Quick Installation

Install [docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/) yourself, then run the following to set up first Odoo instance @ `localhost:10017` (default master password: `P@ss@123`):

``` bash
cd /opt
curl -s https://raw.githubusercontent.com/HaithamSaqr/odoo-17-docker-compose-pgbouncer/master/run.sh | sudo bash -s odoo17 10017 20017
```
and/or run the following to set up another Odoo instance @ `localhost:11017` (default master password: `P@ss@123`):

``` bash
cd /opt
curl -s https://raw.githubusercontent.com/HaithamSaqr/odoo-17-docker-compose-pgbouncer/master/run.sh | sudo bash -s odoo17 11017 21017
```

 to use casa os 

run 

git clone --depth=1 https://github.com/HaithamSaqr/odoo-17-docker-compose-pgbouncer odoo17

then inport   casaos-compose.yml  to casa

 

- **If you get any permission issues**, change the folder permission to make sure that the container is able to access the directory:

``` sh
$ sudo chmod -R 777 addons
$ sudo chmod -R 777 etc
$ sudo chmod -R 777 postgresql
```

- If you want to start the server with a different port, change **10017** to another value in **docker-compose.yml** inside the parent dir:

```
ports:
 - "10017:8069"
```
 
-docker-compose-pgbouncer $DESTINATION
rm -rf $DESTINATION/.git

# Create PostgreSQL directory
mkdir -p $DESTINATION/postgresql

# Change ownership to current user and set restrictive permissions for security
sudo chown -R $USER:$USER $DESTINATION
sudo chmod -R 700 $DESTINATION  # Only the user has access

# Check if running on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Running on macOS. Skipping inotify configuration."
else
  # System configuration
  if grep -qF "fs.inotify.max_user_watches" /etc/sysctl.conf; then
    echo $(grep -F "fs.inotify.max_user_watches" /etc/sysctl.conf)
  else
    echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf
  fi
  sudo sysctl -p
fi

# Set ports in docker-compose.yml
# Update docker-compose configuration
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS sed syntax
  sed -i '' 's/10017/'$PORT'/g' $DESTINATION/docker-compose.yml
  sed -i '' 's/20017/'$CHAT'/g' $DESTINATION/docker-compose.yml
else
  # Linux sed syntax
  sed -i 's/10017/'$PORT'/g' $DESTINATION/docker-compose.yml
  sed -i 's/20017/'$CHAT'/g' $DESTINATION/docker-compose.yml
fi

# Set file and directory permissions after installation
find $DESTINATION -type f -exec chmod 644 {} \;
find $DESTINATION -type d -exec chmod 755 {} \;

# Run Odoo
docker-compose -f $DESTINATION/docker-compose.yml up -d

sudo chmod -R 777 $DESTINATION/addons
sudo chmod -R 777 $DESTINATION/etc
sudo chmod -R 777 $DESTINATION/postgresql
sudo chmod -R 777 $DESTINATION/pgbouncer


echo "Odoo started at http://localhost:$PORT | Master Password: P@ss@123 | Live chat port: $CHAT"
