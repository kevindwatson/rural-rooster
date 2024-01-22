# dash by Kevin Watson @Su_do_nym
# written 19/01/24 from Thu Vu - https://www.youtube.com/watch?v=uhxiXOTKzfs 4.28

# install pip -> open a terminal and type 'sudo apt install python3-pip'
# install hv plot -> in the terminal type 'pip install hvplot'

import pandas as pd
import numpy as np
import panel as pn

pn.extension('tabulator')

import hvplot.pandas

#df = pd.read_csv('https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv')
df = pd.read_csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

print(df)