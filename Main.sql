-- Elimino la tabella Sinistri se già esiste e la creo nuova
DROP TABLE LCdb.dbo.Sinistri

CREATE TABLE LCdb.dbo.Sinistri(
	CodS INT PRIMARY KEY,
	Località varchar(20),
	Data date
)
GO

--Rimuovo la colonna "Rivalutato" dalla tab AutoCoinvolte
ALTER TABLE LCdb.dbo.AutoCoinvolte
DROP COLUMN Rivalutato;
GO

--Testo la presenza del file .csv nella cartella Input
DECLARE @x INT
EXEC master.sys.xp_fileexist 'C:\Input\Sinistri.csv', @x OUTPUT
IF @x = 0
PRINT 'Il file non è stato trovato, ricontrollare il percorso.'
ELSE
PRINT 'File trovato'
--Sposto e rinomino il file in Sinistri2.csv
EXEC master.sys.xp_copy_file
'C:\Input\Sinistri.csv', 
'C:\Processed\Sinistri2.csv';
EXEC master.sys.xp_delete_files
'C:\Input\Sinistri.csv'
GO

--Riempio la tabella da Note.csv contenuto nella cartella Processed
BULK 
INSERT LCdb.dbo.Sinistri
FROM 'C:\Processed\Sinistri2.csv'
WITH (
FIRSTROW = 2,
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
--Genero un .csv di output con la lista degli errori
ERRORFILE = 'C:\Output\Error.csv',
--Basta un errore per annullare tutte le operazioni di inserimento
MAXERRORS = 0
)
GO

--Rivaluto l'importo del danno in caso di data antecedente al 20/01/21 e residenza != sede
UPDATE LCdb.dbo.AutoCoinvolte
--Importo del danno rivalutato del 10%
SET Importodeldanno = Importodeldanno*0.9
FROM LCdb.dbo.Sinistri AS Sin, LCdb.dbo.Auto AS Auto, LCdb.dbo.Proprietari AS P, LCdb.dbo.Assicurazioni AS A
WHERE (
AutoCoinvolte.CodS = Sin.CodS AND 
AutoCoinvolte.targa = Auto.targa AND
Auto.CodF = P.CodF AND Auto.CodAss = A.CodAss AND
--DATEDIFF(day, Sin.Data, '2021-01-20') > 0
Sin.CodS <= 21-01-2021
AND A.Sede != P.Residenza
)
GO
--Aggiungo una colonna "rivalutato" con valori tutti NULL
ALTER TABLE LCdb.dbo.AutoCoinvolte
ADD Rivalutato varchar(2)
GO

--Setto a 'SI' in caso di rivalutazione dell'importo
UPDATE LCdb.dbo.AutoCoinvolte
SET Rivalutato = 'SI'
FROM LCdb.dbo.Sinistri AS Sin, LCdb.dbo.Auto AS Auto, LCdb.dbo.Proprietari AS P, LCdb.dbo.Assicurazioni AS A
WHERE (
AutoCoinvolte.CodS = Sin.CodS AND 
AutoCoinvolte.targa = Auto.targa AND
Auto.CodF = P.CodF AND Auto.CodAss = A.CodAss AND
DATEDIFF(day, Sin.Data, '2021-01-20') > 0 AND A.Sede != P.Residenza
)
GO	
--FACOLTATIVO: mostrare elenco targa, marca, proprietario, importo e rivalutato
SELECT Auto.Targa, Marca, Nome, Rivalutato, ImportodelDanno
FROM LCdb.dbo.Auto AS Auto
INNER JOIN LCdb.dbo.AutoCoinvolte AS A ON A.Targa = Auto.Targa
INNER JOIN LCdb.dbo.Proprietari AS P ON P.CodF = Auto.CodF
GO

