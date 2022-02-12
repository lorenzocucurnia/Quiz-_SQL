--Mostrare il codice dei Sinistri in cui non sono state coinvolte auto con cilindrata inferiore a 2000cc
SELECT CodS
FROM LCdb.dbo.AutoCoinvolte AS AC 
INNER JOIN LCdb.dbo.Auto AS Auto ON Auto.Targa = AC.Targa
WHERE Auto.[Cilindrata(cc)] > 2000