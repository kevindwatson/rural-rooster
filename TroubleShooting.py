# Check installed pip version
#    python -m pip --version
#    or
#    py -m pip --version

# install pip -> open a terminal and type 'sudo apt install python3-pip'
# try py -m pip install --upgrade pip

# install hv plot -> in the terminal type 'pip install hvplot'
# py -m pip install panel
# python -m pip install panel

# pip install pandaspip

# pip install ipykernel
# pip install pandas
# pip install jupyter_bokeh
# pip install nbconvert
# https://panel.holoviz.org/api/panel.widgets.html

import pandas as pd
import requests
import subprocess as sp
import numpy as np
import panel as pn
pn.extension('tabulator')

import hvplot.pandas
