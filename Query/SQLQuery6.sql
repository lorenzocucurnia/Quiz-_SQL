--Mostrare CodF e Nome di coloro che possiedono più di un'auto

DROP TABLE IF EXISTS LCdb.dbo.Temp
GO
--Creo una tabella temporanea
CREATE TABLE LCdb.dbo.Temp(
	CodF INT
	)
GO
--Inserisco i valori di CodF di proprietari con più di un'auto
INSERT INTO LCdb.dbo.Temp(CodF)
SELECT DISTINCT CodF
FROM LCdb.dbo.Auto AS Auto
GROUP BY CodF
HAVING COUNT(CodF) > 1
GO

--Aggiungo la colonna relativa al nome del Proprietario
ALTER TABLE LCdb.dbo.Temp
ADD Nome_Proprietario nvarchar(20)
GO
UPDATE LCdb.dbo.Temp
SET Temp.Nome_Proprietario = P.Nome
FROM LCdb.dbo.Proprietari AS P
WHERE Temp.CodF = P.CodF
GO

--Visualizzo i risultati
SELECT *
FROM LCdb.dbo.Temp
GO

--Elimino la tabella Temp
DROP TABLE LCdb.dbo.Temp
