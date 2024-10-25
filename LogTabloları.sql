CREATE TRIGGER trg_LogKullaniciEkleme
ON Musteriler
FOR INSERT
AS
BEGIN
    DECLARE @KullaniciID INT;
    DECLARE @IslemTarihi DATETIME;
    DECLARE @IslemYapanKullanici NVARCHAR(50);

    SELECT @KullaniciID = MusteriID FROM inserted;

    SET @IslemTarihi = GETDATE(); 
    SET @IslemYapanKullanici = SYSTEM_USER; 

    INSERT INTO LogTablosu (KullaniciID, IslemTipi, IslemTarihi, IslemYapilanKullanici)
    VALUES (@KullaniciID, 'INSERT', @IslemTarihi, @IslemYapanKullanici);
END;

INSERT INTO Musteriler (MusteriAd, MusteriSoyad, MusteriEmail, MusteriNumara) 
VALUES ('Ahmet', 'Yýlmaz', 'ahmet@abc.com', '987654321');

select * from LogTablosu

CREATE TRIGGER trg_LogKullaniciGuncelle
ON Musteriler
FOR UPDATE
AS
BEGIN
    DECLARE @KullaniciID INT;
    DECLARE @IslemTarihi DATETIME;
    DECLARE @IslemYapanKullanici NVARCHAR(50);

    SELECT @KullaniciID = MusteriID FROM inserted;

    SET @IslemTarihi = GETDATE();  
    SET @IslemYapanKullanici = SYSTEM_USER;  

    INSERT INTO LogTablosu (KullaniciID, IslemTipi, IslemTarihi, IslemYapilanKullanici)
    VALUES (@KullaniciID, 'UPDATE', @IslemTarihi, @IslemYapanKullanici);
END;

UPDATE Musteriler
set MusteriEmail = 'eyupkavak@abcd.com' where MusteriID = 1

select * from Musteriler where MusteriID = 1
select * from LogTablosu

create trigger trg_LogKullaniciSilme
on Musteriler
for DELETE
AS
BEGIN
	DECLARE @KullaniciID INT;
    DECLARE @IslemTarihi DATETIME;
    DECLARE @IslemYapanKullanici NVARCHAR(50);

	SELECT @KullaniciID = MusteriID FROM inserted;

	SET @IslemTarihi = GETDATE(); 
    SET @IslemYapanKullanici = SYSTEM_USER;

	INSERT INTO LogTablosu (KullaniciID, IslemTipi, IslemTarihi, IslemYapilanKullanici)
    VALUES (@KullaniciID, 'UPDATE', @IslemTarihi, @IslemYapanKullanici);
END;

delete from Musteriler WHERE MusteriID = 9

select * from LogTablosu




