--https://code.visualstudio.com/docs/languages/tsql
--Open the Extensions view from VS Code Side Bar (Ctrl+Shift+X).
--Type "mssql" in the search bar, click Install, and reload VS Code when prompted.

--https://github.com/microsoft/vscode-mssql/blob/main/CHANGELOG.md


SELECT TOP (1000) [Dashboard]
      ,[Period]
      ,[GeoCode]
      ,[GeoName]
      ,[VariableType]
      ,[VariableA]
      ,[VariableB]
      ,[Value]
  INTO OUTFILE 'C:\Users\Kevin.Watson\Documents\Git\rural-rooster\outputfile.csv'
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n'
  FROM [BirthsDeaths].[dbo].[QA_DashExtract]