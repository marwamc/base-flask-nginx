# Top section copied from http://clarkgrubb.com/makefile-style-guide
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
.DEFAULT_GOAL := start
.DELETE_ON_ERROR:
.SUFFIXES:

# VARS
SERVICE := nginx-service
docker_run := docker run -itd --rm

#-----------------------------------------------------------------------------------------
# SECTION: MANAGE SERVICE
build:
	docker-compose -f nginx-service.yml build

push:


start: build
	docker-compose -f nginx-service.yml up

stop:
	docker-compose -f nginx-service.yml down

# make SERVICE=pyserver restart
restart:
	docker-compose -f nginx-service.yml restart ${SERVICE}

# make SERVICE=pyserver shell
# make SERVICE=postgres_airflow shell
shell:
	docker exec -it ${SERVICE} /bin/bash


cleanup:
	docker rm -vf $(docker ps -a -q)
	docker rmi -f $(docker images -a -q)

default: start

#-----------------------------------------------------------------------------------------
# SECTION: ADMIN