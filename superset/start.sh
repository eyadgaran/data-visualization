#!/bin/bash

# activate conda env
source activate superset

# update
superset db upgrade
superset init

# start server
superset runserver
