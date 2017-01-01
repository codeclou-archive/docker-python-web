#!/bin/bash

cd /pyapp/web/

#
# INSTALL DEPS
#
pip install --target=./extlibs -r requirements.txt

#
# RUN PYTHON SERVER
#
python app.py