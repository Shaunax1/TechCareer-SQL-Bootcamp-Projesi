-- Ýndex Oluþturma 
CREATE INDEX IX_Kiralamalar_MusteriID_FilmID
ON Kiralamalar (MusteriID, FilmID)

SET STATISTICS IO ON;

SELECT * FROM Kiralamalar WHERE MusteriID = 2 and FilmID = 6;

create nonclustered index IX_FilmBilgi
on Filmler (FilmID,FilmIsmi, StokSayisi)

set STATISTICS IO ON

select * from Filmler where FilmID between 1 and 3

SET STATISTICS TIME OFF

-- View oluþturma

CREATE VIEW Vw_MusteriToplamKiralama AS
SELECT 
    m.MusteriID,
    m.MusteriAd,
    m.MusteriSoyad,
    SUM(k.Miktar) AS ToplamKiralama
FROM Musteriler m 
LEFT JOIN Kiralamalar k ON m.MusteriID = k.MusteriID
GROUP BY m.MusteriID, m.MusteriAd, m.MusteriSoyad

select * from Vw_MusteriToplamKiralama

CREATE VIEW vw_MusteriKiralamaOzeti
AS
SELECT 
    M.MusteriID,
    M.MusteriAd + ' ' + M.MusteriSoyad AS MusteriAdi,
    F.FilmIsmi AS KiralananFilm,
    K.KiralamaTarihi,
    K.DonusTarihi,
    K.Miktar,
    (K.Miktar * F.FilmFiyati) AS ToplamOdeme
FROM 
	Kiralamalar K 
	JOIN Musteriler M ON K.MusteriID = M.MusteriID
	JOIN Filmler F ON K.FilmID = F.FilmID


select * from vw_MusteriKiralamaOzeti order by ToplamOdeme desc



-- Prosedür Oluþturma 

create proc ÝkiTarihArasýndakiKiralamalar
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        k.KiralamaID,
        k.MusteriID,
        k.FilmID,
        k.KiralamaTarihi,
        k.DonusTarihi,
        k.Miktar
    FROM Kiralamalar k WHERE k.KiralamaTarihi BETWEEN @StartDate AND @EndDate;
END;

exec dbo.ÝkiTarihArasýndakiKiralamalar '2023/1/1', '2023/5/1'


create proc MusteriKiralamaDetaylari
    @MusteriID INT
AS
BEGIN
    SELECT 
        K.KiralamaID,
        M.MusteriAd + ' ' + M.MusteriSoyad AS MusteriAdi,
        F.FilmIsmi,
        K.KiralamaTarihi,
        K.DonusTarihi,
        F.FilmFiyati,
        (K.Miktar * F.FilmFiyati) AS ToplamOdeme
    FROM 
        Kiralamalar K 
		JOIN Musteriler M ON K.MusteriID = M.MusteriID
		JOIN Filmler F ON K.FilmID = F.FilmID
    WHERE 
        K.MusteriID = @MusteriID
    ORDER BY 
        K.KiralamaTarihi DESC;
END;

exec MusteriKiralamaDetaylari 1

