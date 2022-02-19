/*Mostrare Nome del proprietario e Targa delle auto di cilindrata superiore a 2000 cc oppure potenza
superiore a 120 CV, assicurate presso SARA*/

SELECT P.Nome, Targa
FROM LCdb.dbo.Assicurazioni AS A
INNER JOIN LCdb.dbo.Auto AS Auto ON A.CodAss = Auto.CodAss
INNER JOIN LCdb.dbo.Proprietari AS P ON P.CodF = Auto.CodF
WHERE A.Nome = 'SARA' 
AND (
Auto.[Cilindrata(cc)] > 2000 OR
Auto.[Potenza(CV)] > 120
);