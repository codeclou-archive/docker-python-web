#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import os
import sys

sys.path.append(os.path.dirname(os.path.realpath(__file__)) + "/extlibs/")

from bottle import route, run

@route('/')
def hello():
    return "Hello World!"

run(host='0.0.0.0', port=8000, debug=True)
