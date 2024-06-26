@echo off

set server=SQLClusColLK19\Lake19
set database=BirthsDeaths

sqlcmd -S %server% -d %database% -E -i C:\Users\Kevin.Watson\Documents\Git\rural-rooster\GetLakeDeaths.SQL -o C:\Users\Kevin.Watson\Documents\Git\rural-rooster\outputfile.csv