--Mostrare CodF e Nome di coloro che possiedono più di un'auto


SELECT Auto.CodF, P.Nome
FROM LCdb.dbo.Auto AS Auto
INNER JOIN LCdb.dbo.Proprietari AS P ON P.CodF = Auto.CodF
GROUP BY Auto.CodF, P.Nome
HAVING COUNT(Auto.CodF) > 1
ORDER BY P.Nome ASC;