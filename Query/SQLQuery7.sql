--Mostrare la targa delle auto che non sono state coinvolte in sinistri dopo il 20/01/2021
SELECT Targa
FROM LCdb.dbo.AutoCoinvolte AS AC
INNER JOIN LCdb.dbo.Sinistri AS Sin ON Sin.CodS = AC.CodS
WHERE DATEDIFF(day, Sin.Data, '2021-01-20') > 0