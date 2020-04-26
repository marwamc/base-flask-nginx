# Top section copied from http://clarkgrubb.com/makefile-style-guide
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
.DEFAULT_GOAL := start
.DELETE_ON_ERROR:
.SUFFIXES:

# VARS
SERVICE := pyserver
docker_run := docker run -itd --rm

#-----------------------------------------------------------------------------------------
# SECTION: MANAGE IMAGE
build:
	docker-compose -f pserver.yml build

push:
	docker-compose -f pserver.yml push

#-----------------------------------------------------------------------------------------
# SECTION: RUN IMAGE
start: build
	docker-compose -f pserver.yml up

stop:
	docker-compose -f pyserver.yml down

# make SERVICE=pyserver restart
restart:
	docker-compose -f pyserver.yml restart ${SERVICE}

# make SERVICE=pyserver shell
# make SERVICE=postgres_airflow shell
shell:
	docker exec -it ${SERVICE} /bin/bash


cleanup:
	docker rm -vf $(docker ps -a -q)
	docker rmi -f $(docker images -a -q)

default: start
