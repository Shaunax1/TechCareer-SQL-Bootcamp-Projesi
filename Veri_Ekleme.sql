DECLARE @i int = 1;
DECLARE @MusteriID int;
DECLARE @FilmID int;
DECLARE @KiralamaTarihi date;
DECLARE @DonusTarihi date;
DECLARE @Miktar int;

DECLARE @StartDate DATE = '2023-01-01';
DECLARE @EndDate DATE = '2024-06-01';

DECLARE @TotalDays INT = DATEDIFF(DAY, @StartDate, @EndDate);

WHILE @i <= 1000
BEGIN
    SET @MusteriID = FLOOR(RAND() * 8) + 1;
    SET @FilmID = FLOOR(RAND() * 6) + 1;

    SET @KiralamaTarihi = DATEADD(DAY, FLOOR(RAND() * @TotalDays), @StartDate);

    SET @DonusTarihi = DATEADD(DAY, FLOOR(RAND() * 14) + 1, @KiralamaTarihi);

    SET @Miktar = FLOOR(RAND() * 10) + 1;

    INSERT INTO Kiralamalar(MusteriID, FilmID, KiralamaTarihi, DonusTarihi, Miktar)
    VALUES(@MusteriID, @FilmID, @KiralamaTarihi, @DonusTarihi, @Miktar);

    SET @i = @i + 1;
END;

select COUNT(*) from Kiralamalar

-- en çok kiralanan film sorgusu

SELECT TOP 1 
    f.FilmID,
    f.FilmIsmi,
    SUM(k.Miktar) AS ToplamKiralamaSayisi
FROM Kiralamalar k
JOIN Filmler f ON k.FilmID = f.FilmID
GROUP BY f.FilmID, f.FilmIsmi
ORDER BY ToplamKiralamaSayisi DESC;


-- en çok kiralama yapan müþteri

SELECT TOP 1 
    m.MusteriID,
    m.MusteriAd,
    m.MusteriSoyad,
    SUM(k.Miktar) AS ToplamKiralamaSayisi
FROM Kiralamalar k
JOIN Musteriler m ON k.MusteriID = m.MusteriID
GROUP BY m.MusteriID, m.MusteriAd, m.MusteriSoyad
ORDER BY ToplamKiralamaSayisi DESC;

-- Her müþterinin ilk ve son sipariþleri
WITH MusteriSiparisleri AS (
    SELECT 
        k.MusteriID, 
        k.FilmID, 
        k.KiralamaTarihi, 
        k.Miktar,
        ROW_NUMBER() OVER (PARTITION BY k.MusteriID ORDER BY k.KiralamaTarihi ASC) AS IlkSiparis,
        ROW_NUMBER() OVER (PARTITION BY k.MusteriID ORDER BY k.KiralamaTarihi DESC) AS SonSiparis
    FROM Kiralamalar k
)
SELECT 
    m.MusteriAd + ' ' + m.MusteriSoyad AS MusteriAdiSoyadi, 
    f1.FilmIsmi AS IlkSiparisUrunu, 
    s1.KiralamaTarihi AS IlkSiparisTarihi, 
    s1.Miktar AS IlkSiparisMiktari,
    f2.FilmIsmi AS SonSiparisUrunu, 
    s2.KiralamaTarihi AS SonSiparisTarihi, 
    s2.Miktar AS SonSiparisMiktari
FROM Musteriler m
JOIN MusteriSiparisleri s1 ON m.MusteriID = s1.MusteriID AND s1.IlkSiparis = 1
JOIN MusteriSiparisleri s2 ON m.MusteriID = s2.MusteriID AND s2.SonSiparis = 1
JOIN Filmler f1 ON s1.FilmID = f1.FilmID
JOIN Filmler f2 ON s2.FilmID = f2.FilmID;



