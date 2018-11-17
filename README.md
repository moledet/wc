# Task resolve for Wise Credit 

## Steps to run it
* install [Docker CE](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce-1)
* install [docker-compose](https://docs.docker.com/compose/install/) (for non windows users)
* run docker images by type in console from project folder `docker-compose -f "docker-compose.yml" up -d --build`
* check if project work, go to [http://localhost:9999/](http://localhost:9999/)

## Checking functionality 
For testing all API requests you may use [Postmen](https://www.getpostman.com/) json test collection from file `tests.postman_collection.json`. The list of end points:
* `POST` http://localhost:9999/token create account and get token, send `emal`,`password`
* `GET` http://localhost:9999/account?token=b0eae275e71e89e920025bb289fe56d0adcffb31 get info about account by token
* `GET` http://localhost:9999/entities get list of entities
* `GET` http://localhost:9999/entities/7 get entity by id
* `PUT` http://localhost:9999/entities/8 update entity by id
* `DELETE` http://localhost:9999/entities/9 delete entity by id
* `DELETE` http://localhost:9999/entities delete all entities   

## Stack Technology
For task was used [Kohana](http://kohanaframework.org/) framework with native module Auth. Framework same that company use in production and module Auth it's fast implementation for token creation task. 

The database structure in ./phpdocker/dump.sql that passed via docker into `kohana-mysql` image. For access to db you may use `port`:10001 `user`: webapp `password`: 46Cf8dpN5bnGUGc2WAzvQ

The docker's files was modificated after get them from [phpdocker.io](phpdocker.io) project.
