import pandas as pd
import requests

# Get link from: https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/deathsregisteredinenglandandwalesseriesdrreferencetables
# xls = pd.ExcelFile('https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/deathsregisteredinenglandandwalesseriesdrreferencetables/2022/dr2022corrected.xlsx')

# The url doesn't accept "non-browser" requests. The default header of Python requests is 'User-Agent': 'python-requests/2.13.0', need to pass different headers as an argument
# https://stackoverflow.com/questions/59297759/python-requests-module-to-download-an-excel-file-from-a-download-link-which-po

# GET FILE
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.76 Safari/537.36'}
response = requests.get('https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/deathsregisteredinenglandandwalesseriesdrreferencetables/2022/dr2022corrected.xlsx', headers=headers, verify=False)
with open("DeathsData.xlsx", 'wb') as f:
    f.write(response.content)

# Bring in a tab of the xlsx as a data frame
df = pd.read_excel('DeathsData.xlsx', sheet_name='2b', skiprows=4)
print(df)