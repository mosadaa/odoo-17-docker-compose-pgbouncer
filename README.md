# Installing Odoo 17.0 with one command (Supports multiple Odoo instances on one server).

## Quick Installation

Install [docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/) yourself, then run the following to set up first Odoo instance @ `localhost:10017` (default master password: `P@ss@123`):

``` bash
cd /opt
curl -s https://raw.githubusercontent.com/mosadaa/odoo-17-docker-compose-pgbouncer/master/run.sh | sudo bash -s odoo17 10017 20017
```
and/or run the following to set up another Odoo instance @ `localhost:11017` (default master password: `P@ss@123`):

``` bash
cd /opt
curl -s https://raw.githubusercontent.com/HaithamSaqr/odoo-17-docker-compose-pgbouncer/master/run.sh | sudo bash -s odoo17 11017 21017
```

 to use casa os 

run 

git clone --depth=1 https://github.com/mosadaa/odoo-17-docker-compose-pgbouncer odoo17

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
 
