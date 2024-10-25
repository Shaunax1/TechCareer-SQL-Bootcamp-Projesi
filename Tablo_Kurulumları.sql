create database dvdrent
use dvdrent

create table Musteriler
(
MusteriID int primary key identity(1,1),
MusteriAd varchar(70),
MusteriSoyad varchar(70),
MusteriEmail varchar(100),
MusteriNumara nvarchar(15)
);

create table Filmler
(
FilmID int primary key identity(1,1),
FilmIsmi varchar(100),
FilmKategori varchar(50),
FilmYili date,
FilmFiyati decimal(10,2),
StokSayisi int
);

create table Kiralamalar
(
	KiralamaID int primary key identity(1,1),
	KiralamaTarihi date,
	DonusTarihi date,
	Miktar int,
	MusteriID int foreign key (MusteriID) references Musteriler(MusteriID),
	FilmID int foreign key (FilmID) references Filmler(FilmID)
);


SET DATEFORMAT DMY

insert into Musteriler (MusteriAd,MusteriSoyad,MusteriEmail,MusteriNumara) values
('Ey�p','Kavak','eypk@abc.com','123456789'),
('Ali','Y�ld�r�m','aliy@abc.com','132456789'),
('Bora','E�ilmez','borae@abc.com','124356789'),
('G�ktu�','Kaya','g�ktu�k@abc.com','123465789'),
('Cengiz','Han','cengizh@abc.com','123456879'),
('�lteri�','Ka�an','ilterisk@abc.com','213456798'),
('Ayb�ke','�z','aybk�@abc.com','127456389'),
('�a�la','Duman','caglad@abc.com','193456782')

SELECT * FROM Musteriler

insert into Filmler (FilmIsmi,FilmKategori,FilmYili,StokSayisi,FilmFiyati) values
('Esaretin Bedeli', 'Drama', '1994', 100, 20),
('The Godfather', 'Su�', '1972', 75, 50),
('Kara ��valye', 'Aksiyon', '1994', 120, 15),
('Y�z�klerin Efendisi Y�z�k Karde�li�i', 'Aksiyon', '2001', 85, 30),
('Y�ld�zlararas�', 'Bilim Kurgu', '2014', 100, 25),
('Gelece�e D�n��', 'Komedi', '1985', 50, 5)

select * from Filmler


create table LogTablosu
(
	LogID int identity(1,1) primary key,
	KullaniciID int,
	IslemTipi varchar(50),
	IslemTarihi datetime,
	IslemYapilanKullanici varchar(50)
);

--select * from LogTablosu

