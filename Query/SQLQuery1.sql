--Mostra targa e Marca delle Auto di cilindrata superiore a 2000 cc o di potenza superiore a 120 CV
SELECT Targa, Marca
FROM LCdb.dbo.Auto AS Auto
WHERE Auto.[Cilindrata(cc)] > 2000 OR
Auto.[Potenza(CV)] > 120