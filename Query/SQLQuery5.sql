--Per ciascuna auto coinvolta in più di un sinistro, mostrare la targa, assicurazione e import del danno 

--Creo una tabella temporanea
CREATE TABLE LCdb.dbo.Temp(
	Targa nvarchar(7),
	Num_Sinistri INT
	)
GO
--Inserisco la targa e il conteggio delle volte in cui l'auto è coinvolta in un sinistro
INSERT INTO LCdb.dbo.Temp (Num_Sinistri, Targa)
SELECT DISTINCT COUNT(*) AS Num_Sinistri, A.Targa
FROM LCdb.dbo.Auto AS Auto
INNER JOIN LCdb.dbo.AutoCoinvolte AS A ON A.Targa = Auto.Targa
GROUP BY A.Targa
GO

--Aggiungo la colonna relativa al nome dell'Assicurazione
ALTER TABLE LCdb.dbo.Temp
ADD Nome_Assicurazione nvarchar(20)
GO
UPDATE LCdb.dbo.Temp
SET Temp.Nome_Assicurazione = A.Nome
FROM LCdb.dbo.Assicurazioni AS A, LCdb.dbo.Auto AS Auto
WHERE Temp.Targa = Auto.Targa
AND Auto.CodAss = A.CodAss
GO

--Aggiungo la colonna con l'importo del danno
ALTER TABLE LCdb.dbo.Temp
ADD Totale_Danno float
GO
UPDATE LCdb.dbo.Temp
SET Temp.Totale_Danno = AC.Importodeldanno
FROM LCdb.dbo.AutoCoinvolte AS AC
WHERE Temp.Targa = AC.Targa
GO

--Visualizzo targa, assicurazione e importo
SELECT Targa, Nome_Assicurazione, Totale_Danno
FROM LCdb.dbo.Temp AS Temp
WHERE Temp.Num_Sinistri > 1
GO

--Elimino la tabella temporanea
DROP TABLE LCdb.dbo.Temp