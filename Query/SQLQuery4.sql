--Per ciascuna auto Fiat, mostrare la targa dell'auto ed il numero di sinistri in cui è coinvolta

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

--Aggiungo la colonna Marca e inserisco i valori
ALTER TABLE LCdb.dbo.Temp
ADD Marca nvarchar(20)
GO
UPDATE LCdb.dbo.Temp
SET Temp.Marca = Auto.Marca
FROM LCdb.dbo.Auto AS Auto
WHERE Temp.Targa = Auto.Targa
GO

--Visualizzo solo le auto di marca Fiat
SELECT *
FROM LCdb.dbo.Temp AS Temp
WHERE Temp.Marca LIKE 'Fiat%'
GO

--Elimino la tabella temporanea
DROP TABLE LCdb.dbo.Temp