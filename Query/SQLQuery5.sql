--Per ciascuna auto coinvolta in più di un sinistro, mostrare la targa, assicurazione ed il totale dei danni riportati 


SELECT AC.Targa, A.Nome, SUM(AC.Importodeldanno) AS Totale_danno
FROM LCdb.dbo.Auto AS Auto
INNER JOIN LCdb.dbo.AutoCoinvolte AS AC ON AC.Targa = Auto.Targa
INNER JOIN LCdb.dbo.Assicurazioni AS A ON A.CodAss = Auto.CodAss
GROUP BY AC.Targa, A.Nome
HAVING COUNT(AC.Targa) > 1
ORDER BY AC.Targa ASC