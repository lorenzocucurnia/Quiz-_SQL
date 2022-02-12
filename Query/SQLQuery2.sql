--Mostrare Nome del proprietario e Targa delle auto di cilindrata superiore a 2000 cc oppure potenza
--superiore a 120 CV
SELECT Nome, Targa
FROM LCdb.dbo.Auto AS Auto
INNER JOIN LCdb.dbo.Proprietari AS P ON P.CodF = Auto.CodF
WHERE Auto.[Cilindrata(cc)] > 2000 OR
Auto.[Potenza(CV)] > 120