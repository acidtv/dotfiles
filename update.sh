#!/bin/sh

ansible-playbook -e "curdir=`pwd` home=$HOME" -c local localhost.yml
