#!/bin/bash

cd /opt/python/web/

#
# INSTALL DEPS
#
pip install --target=./extlibs -r requirements.txt

#
# RUN PYTHON SERVER
#
python app.py