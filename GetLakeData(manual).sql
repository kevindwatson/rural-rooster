DECLARE @Period VARCHAR(4) = '2022'

SELECT [Period], [Base], [Variable], [Value]

FROM (
	  SELECT @Period AS [Period], 'LA' AS [Base], CASE WHEN [xONS_LTLA23] IN ('E06000052', 'E06000053') THEN 'E06000052, E06000053' ELSE [xONS_LTLA23] END AS [Variable], COUNT(*) AS [Value]
	  	FROM [BirthsDeaths].[dbo].[vDeathsALL]
	  	WHERE [xYear] = @Period
	  	GROUP BY [xONS_LTLA23]
	  
	  UNION ALL
	  
	  --Counts by gender, 1 = male and 2 = female
	  SELECT @Period AS [Period], 'Sex' AS [Base], CAST([Sex] AS CHAR(1)) AS [Variable], COUNT(*) AS [Value]
	  	FROM [BirthsDeaths].[dbo].[vDeathsALL]
	  	WHERE [xYear] = @Period
	  	GROUP BY [Sex]
	  
	  UNION ALL
	  
	  --[Age_Unit] = 1 means [Age_UnitVal] is in years, [Age_Unit] = 2, 3 or 4 means months, weeks or days
	  SELECT @Period AS [Period], 'Age' AS [Base], CASE WHEN [Age_Unit] <> 1 THEN '0' ELSE CAST([Age_UnitVal] AS VARCHAR(20)) END AS [Variable], COUNT(*) AS [Value]
	  	FROM [BirthsDeaths].[dbo].[vDeathsALL]
	  	WHERE [xYear] = @Period
	  	GROUP BY CASE WHEN [Age_Unit] <> 1 THEN '0' ELSE CAST([Age_UnitVal] AS VARCHAR(20)) END
	  
	  UNION ALL
	  
	  --[Neo_Ind] should be 1 where [UCOD] is blank and [UCOD] should be blank where [Neo_Ind] = 1
	  SELECT @Period AS [Period], 'NeoCheck' AS [Base], 'UCOD' [Variable], COUNT(*) AS [Value]
	  	FROM [BirthsDeaths].[dbo].[vDeathsALL]
	  	WHERE [xYear] = @Period
	  	AND (([UCOD] = '' AND [Neo_Ind] <> 1) OR ([UCOD] <> '' AND [Neo_Ind] = 1))
	  
	  UNION ALL
	  
	  --[Neo_Ind] should be 1 where [Age_Unit] = 1 or 2 and [Neo_Ind] should be blank where [Age_Unit] = 3 or 4 (there probably will be some though)
	  SELECT @Period AS [Period], 'NeoCheck' AS [Base], 'Age' [Variable], COUNT(*) AS [Value]
	  	FROM [BirthsDeaths].[dbo].[vDeathsALL]
	  	WHERE [xYear] = @Period
	  	AND (([Age_Unit] IN (1,2) AND [Neo_Ind] = 1) OR ([Age_Unit] IN (4,3) AND [Neo_Ind] <> 1))
	  
	  UNION ALL
	  
	  --Extract counts by cause of death
	  SELECT @Period AS [Period], 'Cause' AS [Base], 
	  		CASE WHEN LEFT([UCOD],1) IN ('A','B') THEN 'A00-B99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'C00' AND 'D48' THEN 'C00-D48'
	  			WHEN LEFT([UCOD],3) BETWEEN 'D50' AND 'D89' THEN 'D50-D89'
	  			WHEN LEFT([UCOD],3) BETWEEN 'E00' AND 'E90' THEN 'E00-E90'
	  			WHEN LEFT([UCOD],3) BETWEEN 'F00' AND 'F99' THEN 'F00-F99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'G00' AND 'G99' THEN 'G00-G99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'H00' AND 'H59' THEN 'H00-H59'
	  			WHEN LEFT([UCOD],3) BETWEEN 'H60' AND 'H95' THEN 'H60-H95'
	  			WHEN LEFT([UCOD],3) BETWEEN 'I00' AND 'I99' THEN 'I00-I99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'J00' AND 'J99' THEN 'J00-J99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'K00' AND 'K93' THEN 'K00-K93'
	  			WHEN LEFT([UCOD],3) BETWEEN 'L00' AND 'L99' THEN 'L00-L99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'M00' AND 'M99' THEN 'M00-M99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'N00' AND 'N99' THEN 'N00-N99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'O00' AND 'O99' THEN 'O00-O99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'P00' AND 'P96' THEN 'P00-P96'
	  			WHEN LEFT([UCOD],3) BETWEEN 'Q00' AND 'Q99' THEN 'Q00-Q99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'R00' AND 'R99' THEN 'R00-R99'
	  			WHEN (LEFT([UCOD],4) = 'U509' OR LEFT([UCOD],3) BETWEEN 'V01' AND 'Y89') THEN 'U509,V01-Y89'
	  		ELSE '' END AS [Variable], COUNT(*) AS [Value]
	  	FROM [BirthsDeaths].[dbo].[vDeathsALL]
	  	WHERE [xYear] = @Period AND [Neo_Ind] IS NULL
	  	GROUP BY CASE WHEN LEFT([UCOD],1) IN ('A','B') THEN 'A00-B99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'C00' AND 'D48' THEN 'C00-D48'
	  			WHEN LEFT([UCOD],3) BETWEEN 'D50' AND 'D89' THEN 'D50-D89'
	  			WHEN LEFT([UCOD],3) BETWEEN 'E00' AND 'E90' THEN 'E00-E90'
	  			WHEN LEFT([UCOD],3) BETWEEN 'F00' AND 'F99' THEN 'F00-F99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'G00' AND 'G99' THEN 'G00-G99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'H00' AND 'H59' THEN 'H00-H59'
	  			WHEN LEFT([UCOD],3) BETWEEN 'H60' AND 'H95' THEN 'H60-H95'
	  			WHEN LEFT([UCOD],3) BETWEEN 'I00' AND 'I99' THEN 'I00-I99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'J00' AND 'J99' THEN 'J00-J99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'K00' AND 'K93' THEN 'K00-K93'
	  			WHEN LEFT([UCOD],3) BETWEEN 'L00' AND 'L99' THEN 'L00-L99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'M00' AND 'M99' THEN 'M00-M99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'N00' AND 'N99' THEN 'N00-N99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'O00' AND 'O99' THEN 'O00-O99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'P00' AND 'P96' THEN 'P00-P96'
	  			WHEN LEFT([UCOD],3) BETWEEN 'Q00' AND 'Q99' THEN 'Q00-Q99'
	  			WHEN LEFT([UCOD],3) BETWEEN 'R00' AND 'R99' THEN 'R00-R99'
	  			WHEN (LEFT([UCOD],4) = 'U509' OR LEFT([UCOD],3) BETWEEN 'V01' AND 'Y89') THEN 'U509,V01-Y89'
	  		ELSE '' END
	  
	  UNION ALL
	  
	  --Trend check:
	  SELECT @Period AS [Period], 'TREND' AS [Base], [xYear] AS [Variable], COUNT(*) AS [Value]
	  	FROM [BirthsDeaths].[dbo].[vDeathsALL]
	  	WHERE [xYear] > '2015'
	  	GROUP BY [xYear]
               ) S