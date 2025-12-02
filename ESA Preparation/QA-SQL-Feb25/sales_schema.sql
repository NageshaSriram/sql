create database sales;
use sales;
/*******************************************************************************
   Create Tables
********************************************************************************/
CREATE TABLE album
(
    albumid INT NOT NULL,
    title NVARCHAR(160) NOT NULL,
    artistid INT NOT NULL,
    CONSTRAINT `PK_Album` PRIMARY KEY  (albumid)
);

CREATE TABLE artist
(
    artistid INT NOT NULL,
    name NVARCHAR(120),
    CONSTRAINT `PK_Artist` PRIMARY KEY  (artistid)
);

CREATE TABLE customer
(
    customerid INT NOT NULL,
    firstname NVARCHAR(40) NOT NULL,
    lastname NVARCHAR(20) NOT NULL,
    company NVARCHAR(80),
    address NVARCHAR(70),
    city NVARCHAR(40),
    state NVARCHAR(40),
    country NVARCHAR(40),
    postalcode NVARCHAR(10),
   phone NVARCHAR(24),
    fax NVARCHAR(24),
   email NVARCHAR(60) NOT NULL,
    supportrepid INT,
    CONSTRAINT `PK_Customer` PRIMARY KEY  (customerid)
);

CREATE TABLE employee
(
    employeeid INT NOT NULL,
    lastname NVARCHAR(20) NOT NULL,
    firstname NVARCHAR(20) NOT NULL,
    title NVARCHAR(30),
    reportsto INT,
    birthdate DATETIME,
    hiredate DATETIME,
    address NVARCHAR(70),
    city NVARCHAR(40),
    state NVARCHAR(40),
    country NVARCHAR(40),
    postalcode NVARCHAR(10),
   phone NVARCHAR(24),
    fax NVARCHAR(24),
   email NVARCHAR(60),
    CONSTRAINT `PK_Employee` PRIMARY KEY  (employeeid)
);

CREATE TABLE genre
(
    genreid INT NOT NULL,
    name NVARCHAR(120),
    CONSTRAINT `PK_Genre` PRIMARY KEY  (genreid)
);

CREATE TABLE invoice
(
    invoiceid INT NOT NULL,
    customerid INT NOT NULL,
    invoicedate DATETIME NOT NULL,
    billingaddress NVARCHAR(70),
     billingcity NVARCHAR(40),
     billingstate NVARCHAR(40),
     billingcountry NVARCHAR(40),
    billingpostalcode NVARCHAR(10),
     total NUMERIC(10,2) NOT NULL,
    CONSTRAINT `PK_Invoice` PRIMARY KEY  (invoiceid)
);

CREATE TABLE invoiceline
(
    invoicelineid INT NOT NULL,
    invoiceid INT NOT NULL,
    trackid INT NOT NULL,
    unitprice NUMERIC(10,2) NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT `PK_InvoiceLine` PRIMARY KEY  (invoicelineid)
);

CREATE TABLE  mediatype
(
    mediatypeid INT NOT NULL,
    name NVARCHAR(120),
    CONSTRAINT `PK_MediaType` PRIMARY KEY  (mediatypeid)
);

CREATE TABLE playlist
(
    playlistid INT NOT NULL,
    name NVARCHAR(120),
    CONSTRAINT `PK_Playlist` PRIMARY KEY  (playlistid)
);

CREATE TABLE playlisttrack
(
    playlistid INT NOT NULL,
    trackid INT NOT NULL,
    CONSTRAINT `PK_PlaylistTrack` PRIMARY KEY  (playlistid, trackid)
);

CREATE TABLE track
(
    trackid INT NOT NULL,
    name NVARCHAR(200) NOT NULL,
    albumid INT,
    mediatypeid INT NOT NULL,
    genreid INT,
    composer NVARCHAR(220),
    milliseconds INT NOT NULL,
    bytes INT,
    unitprice NUMERIC(10,2) NOT NULL,
    CONSTRAINT `PK_Track` PRIMARY KEY  (trackid)
);



/*******************************************************************************
   Create Primary Key Unique Indexes
********************************************************************************/

/*******************************************************************************
   Create Foreign Keys
********************************************************************************/
ALTER TABLE album ADD CONSTRAINT `FK_AlbumArtistId`
    FOREIGN KEY (artistid) REFERENCES artist (artistid) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX `IFK_AlbumArtistId` ON album (artistid);

ALTER TABLE customer ADD CONSTRAINT `FK_CustomerSupportRepId`
    FOREIGN KEY (supportrepid) REFERENCES employee (employeeid) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX `IFK_CustomerSupportRepId` ON customer (supportrepid);

ALTER TABLE employee ADD CONSTRAINT `FK_EmployeeReportsTo`
    FOREIGN KEY (reportsto) REFERENCES employee (employeeid) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX `IFK_EmployeeReportsTo` ON employee (reportsto);

ALTER TABLE invoice ADD CONSTRAINT `FK_InvoiceCustomerId`
    FOREIGN KEY (customerid) REFERENCES customer (customerid) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX `IFK_InvoiceCustomerId` ON invoice (customerid);

ALTER TABLE invoiceline ADD CONSTRAINT `FK_InvoiceLineInvoiceId`
    FOREIGN KEY (invoiceid) REFERENCES invoice (invoiceid) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX `IFK_InvoiceLineInvoiceId` ON invoiceline (invoiceid);

ALTER TABLE invoiceline ADD CONSTRAINT `FK_InvoiceLineTrackId`
    FOREIGN KEY (trackid) REFERENCES track (trackid) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX `IFK_InvoiceLineTrackId` ON invoiceline (trackid);

ALTER TABLE playlisttrack ADD CONSTRAINT `FK_PlaylistTrackPlaylistId`
    FOREIGN KEY (playlistid) REFERENCES playlist (playlistid) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE playlisttrack ADD CONSTRAINT `FK_PlaylistTrackTrackId`
    FOREIGN KEY (trackid) REFERENCES track (trackid) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX `IFK_PlaylistTrackTrackId` ON playlisttrack (trackid);

ALTER TABLE track ADD CONSTRAINT `FK_TrackAlbumId`
    FOREIGN KEY (albumid) REFERENCES album (albumid) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX `IFK_TrackAlbumId` ON track (albumid);

ALTER TABLE track ADD CONSTRAINT `FK_TrackGenreId`
    FOREIGN KEY (genreid) REFERENCES genre (genreid) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX `IFK_TrackGenreId` ON track (genreid);

ALTER TABLE track ADD CONSTRAINT `FK_TrackMediaTypeId`
    FOREIGN KEY (mediatypeid) REFERENCES  mediatype (mediatypeid) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX `IFK_TrackMediaTypeId` ON track (mediatypeid);


/*******************************************************************************
   Populate Tables
********************************************************************************/
INSERT INTO genre (genreid, name) VALUES (1, N'Rock'), (2, N'Jazz'), (3, N'Metal'), (4, N'Alternative & Punk'), (5, N'Rock And Roll'), (6, N'Blues'), (7, N'Latin'), (8, N'Reggae'), (9, N'Pop'), (10, N'Soundtrack'), (11, N'Bossa Nova'), (12, N'Easy Listening'), (13, N'Heavy Metal'), (14, N'R&B/Soul'), (15, N'Electronica/Dance'), (16, N'World'), (17, N'Hip Hop/Rap'), (18, N'Science Fiction'), (19, N'TV Shows'), (20, N'Sci Fi & Fantasy'), (21, N'Drama'), (22, N'Comedy'), (23, N'Alternative'), (24, N'Classical'), (25, N'Opera');

INSERT INTO  mediatype (mediatypeid, name) VALUES (1, N'MPEG audio file'), (2, N'Protected AAC audio file'), (3, N'Protected MPEG-4 video file'), (4, N'Purchased AAC audio file'), (5, N'AAC audio file');

INSERT INTO artist (artistid, name) VALUES (1, N'AC/DC'), (2, N'Accept'), (3, N'Aerosmith'), (4, N'Alanis Morissette'), (5, N'Alice In Chains'), (6, N'Antônio Carlos Jobim'), (7, N'Apocalyptica'), (8, N'Audioslave'), (9, N'BackBeat'), (10, N'Billy Cobham'), (11, N'Black Label Society'), (12, N'Black Sabbath'), (13, N'Body Count'), (14, N'Bruce Dickinson'), (15, N'Buddy Guy'), (16, N'Caetano Veloso'), (17, N'Chico Buarque'), (18, N'Chico Science & Nação Zumbi'), (19, N'Cidade Negra'), (20, N'Cláudio Zoli'), (21, N'Various Artists'), (22, N'Led Zeppelin'), (23, N'Frank Zappa & Captain Beefheart'), (24, N'Marcos Valle'), (25, N'Milton Nascimento & Bebeto'), (26, N'Azymuth'), (27, N'Gilberto Gil'), (28, N'João Gilberto'), (29, N'Bebel Gilberto'), (30, N'Jorge Vercilo'), (31, N'Baby Consuelo'), (32, N'Ney Matogrosso'), (33, N'Luiz Melodia'), (34, N'Nando Reis'), (35, N'Pedro Luís & A Parede'), (36, N'O Rappa'), (37, N'Ed Motta'), (38, N'Banda Black Rio'), (39, N'Fernanda Porto'), (40, N'Os Cariocas'), (41, N'Elis Regina'), (42, N'Milton Nascimento'), (43, N'A Cor Do Som'), (44, N'Kid Abelha'), (45, N'Sandra De Sá'), (46, N'Jorge Ben'), (47, N'Hermeto Pascoal'), (48, N'Barão Vermelho'), (49, N'Edson, DJ Marky & DJ Patife Featuring Fernanda Porto'), (50, N'Metallica'), (51, N'Queen'), (52, N'Kiss'), (53, N'Spyro Gyra'), (54, N'Green Day'), (55, N'David Coverdale'), (56, N'Gonzaguinha'), (57, N'Os Mutantes'), (58, N'Deep Purple'), (59, N'Santana'), (60, N'Santana Feat. Dave Matthews'), (61, N'Santana Feat. Everlast'), (62, N'Santana Feat. Rob Thomas'), (63, N'Santana Feat. Lauryn Hill & Cee-Lo'), (64, N'Santana Feat. The Project G&B'), (65, N'Santana Feat. Maná'), (66, N'Santana Feat. Eagle-Eye Cherry'), (67, N'Santana Feat. Eric Clapton'), (68, N'Miles Davis'), (69, N'Gene Krupa'), (70, N'Toquinho & Vinícius'), (71, N'Vinícius De Moraes & Baden Powell'), (72, N'Vinícius De Moraes'), (73, N'Vinícius E Qurteto Em Cy'), (74, N'Vinícius E Odette Lara'), (75, N'Vinicius, Toquinho & Quarteto Em Cy'), (76, N'Creedence Clearwater Revival'), (77, N'Cássia Eller'), (78, N'Def Leppard'), (79, N'Dennis Chambers'), (80, N'Djavan'), (81, N'Eric Clapton'), (82, N'Faith No More'), (83, N'Falamansa'), (84, N'Foo Fighters'), (85, N'Frank Sinatra'), (86, N'Funk Como Le Gusta'), (87, N'Godsmack'), (88, N'Guns N'' Roses'), (89, N'Incognito'), (90, N'Iron Maiden'), (91, N'James Brown'), (92, N'Jamiroquai'), (93, N'JET'), (94, N'Jimi Hendrix'), (95, N'Joe Satriani'), (96, N'Jota Quest'), (97, N'João Suplicy'), (98, N'Judas Priest'), (99, N'Legião Urbana'), (100, N'Lenny Kravitz'), (101, N'Lulu Santos'), (102, N'Marillion'), (103, N'Marisa Monte'), (104, N'Marvin Gaye'), (105, N'Men At Work'), (106, N'Motörhead'), (107, N'Motörhead & Girlschool'), (108, N'Mônica Marianno'), (109, N'Mötley Crüe'), (110, N'Nirvana'), (111, N'O Terço'), (112, N'Olodum'), (113, N'Os Paralamas Do Sucesso'), (114, N'Ozzy Osbourne'), (115, N'Page & Plant'), (116, N'Passengers'), (117, N'Paul D''Ianno'), (118, N'Pearl Jam'), (119, N'Peter Tosh'), (120, N'Pink Floyd'), (121, N'Planet Hemp'), (122, N'R.E.M. Feat. Kate Pearson'), (123, N'R.E.M. Feat. KRS-One'), (124, N'R.E.M.'), (125, N'Raimundos'), (126, N'Raul Seixas'), (127, N'Red Hot Chili Peppers'), (128, N'Rush'), (129, N'Simply Red'), (130, N'Skank'), (131, N'Smashing Pumpkins'), (132, N'Soundgarden'), (133, N'Stevie Ray Vaughan & Double Trouble'), (134, N'Stone Temple Pilots'), (135, N'System Of A Down'), (136, N'Terry Bozzio, Tony Levin & Steve Stevens'), (137, N'The Black Crowes'), (138, N'The Clash'), (139, N'The Cult'), (140, N'The Doors'), (141, N'The Police'), (142, N'The Rolling Stones'), (143, N'The Tea Party'), (144, N'The Who'), (145, N'Tim Maia'), (146, N'Titãs'), (147, N'Battlestar Galactica'), (148, N'Heroes'), (149, N'Lost'), (150, N'U2'), (151, N'UB40'), (152, N'Van Halen'), (153, N'Velvet Revolver'), (154, N'Whitesnake'), (155, N'Zeca Pagodinho'), (156, N'The Office'), (157, N'Dread Zeppelin'), (158, N'Battlestar Galactica (Classic)'), (159, N'Aquaman'), (160, N'Christina Aguilera featuring BigElf'), (161, N'Aerosmith & Sierra Leone''s Refugee Allstars'), (162, N'Los Lonely Boys'), (163, N'Corinne Bailey Rae'), (164, N'Dhani Harrison & Jakob Dylan'), (165, N'Jackson Browne'), (166, N'Avril Lavigne'), (167, N'Big & Rich'), (168, N'Youssou N''Dour'), (169, N'Black Eyed Peas'), (170, N'Jack Johnson'), (171, N'Ben Harper'), (172, N'Snow Patrol'), (173, N'Matisyahu'), (174, N'The Postal Service'), (175, N'Jaguares'), (176, N'The Flaming Lips'), (177, N'Jack''s Mannequin & Mick Fleetwood'), (178, N'Regina Spektor'), (179, N'Scorpions'), (180, N'House Of Pain'), (181, N'Xis'), (182, N'Nega Gizza'), (183, N'Gustavo & Andres Veiga & Salazar'), (184, N'Rodox'), (185, N'Charlie Brown Jr.'), (186, N'Pedro Luís E A Parede'), (187, N'Los Hermanos'), (188, N'Mundo Livre S/A'), (189, N'Otto'), (190, N'Instituto'), (191, N'Nação Zumbi'), (192, N'DJ Dolores & Orchestra Santa Massa'), (193, N'Seu Jorge'), (194, N'Sabotage E Instituto'), (195, N'Stereo Maracana'), (196, N'Cake'), (197, N'Aisha Duo'), (198, N'Habib Koité and Bamada'), (199, N'Karsh Kale'), (200, N'The Posies'), (201, N'Luciana Souza/Romero Lubambo'), (202, N'Aaron Goldberg'), (203, N'Nicolaus Esterhazy Sinfonia'), (204, N'Temple of the Dog'), (205, N'Chris Cornell'), (206, N'Alberto Turco & Nova Schola Gregoriana'), (207, N'Richard Marlow & The Choir of Trinity College, Cambridge'), (208, N'English Concert & Trevor Pinnock'), (209, N'Anne-Sophie Mutter, Herbert Von Karajan & Wiener Philharmoniker'), (210, N'Hilary Hahn, Jeffrey Kahane, Los Angeles Chamber Orchestra & Margaret Batjer'), (211, N'Wilhelm Kempff'), (212, N'Yo-Yo Ma'), (213, N'Scholars Baroque Ensemble'), (214, N'Academy of St. Martin in the Fields & Sir Neville Marriner'), (215, N'Academy of St. Martin in the Fields Chamber Ensemble & Sir Neville Marriner'), (216, N'Berliner Philharmoniker, Claudio Abbado & Sabine Meyer'), (217, N'Royal Philharmonic Orchestra & Sir Thomas Beecham'), (218, N'Orchestre Révolutionnaire et Romantique & John Eliot Gardiner'), (219, N'Britten Sinfonia, Ivor Bolton & Lesley Garrett'), (220, N'Chicago Symphony Chorus, Chicago Symphony Orchestra & Sir Georg Solti'), (221, N'Sir Georg Solti & Wiener Philharmoniker'), (222, N'Academy of St. Martin in the Fields, John Birch, Sir Neville Marriner & Sylvia McNair'), (223, N'London Symphony Orchestra & Sir Charles Mackerras'), (224, N'Barry Wordsworth & BBC Concert Orchestra'), (225, N'Herbert Von Karajan, Mirella Freni & Wiener Philharmoniker'), (226, N'Eugene Ormandy'), (227, N'Luciano Pavarotti'), (228, N'Leonard Bernstein & New York Philharmonic'), (229, N'Boston Symphony Orchestra & Seiji Ozawa'), (230, N'Aaron Copland & London Symphony Orchestra'), (231, N'Ton Koopman'), (232, N'Sergei Prokofiev & Yuri Temirkanov'), (233, N'Chicago Symphony Orchestra & Fritz Reiner'), (234, N'Orchestra of The Age of Enlightenment'), (235, N'Emanuel Ax, Eugene Ormandy & Philadelphia Orchestra'), (236, N'James Levine'), (237, N'Berliner Philharmoniker & Hans Rosbaud'), (238, N'Maurizio Pollini'), (239, N'Academy of St. Martin in the Fields, Sir Neville Marriner & William Bennett'), (240, N'Gustav Mahler'), (241, N'Felix Schmidt, London Symphony Orchestra & Rafael Frühbeck de Burgos'), (242, N'Edo de Waart & San Francisco Symphony'), (243, N'Antal Doráti & London Symphony Orchestra'), (244, N'Choir Of Westminster Abbey & Simon Preston'), (245, N'Michael Tilson Thomas & San Francisco Symphony'), (246, N'Chor der Wiener Staatsoper, Herbert Von Karajan & Wiener Philharmoniker'), (247, N'The King''s Singers'), (248, N'Berliner Philharmoniker & Herbert Von Karajan'), (249, N'Sir Georg Solti, Sumi Jo & Wiener Philharmoniker'), (250, N'Christopher O''Riley'), (251, N'Fretwork'), (252, N'Amy Winehouse'), (253, N'Calexico'), (254, N'Otto Klemperer & Philharmonia Orchestra'), (255, N'Yehudi Menuhin'), (256, N'Philharmonia Orchestra & Sir Neville Marriner'), (257, N'Academy of St. Martin in the Fields, Sir Neville Marriner & Thurston Dart'), (258, N'Les Arts Florissants & William Christie'), (259, N'The 12 Cellists of The Berlin Philharmonic'), (260, N'Adrian Leaper & Doreen de Feis'), (261, N'Roger Norrington, London Classical Players'), (262, N'Charles Dutoit & L''Orchestre Symphonique de Montréal'), (263, N'Equale Brass Ensemble, John Eliot Gardiner & Munich Monteverdi Orchestra and Choir'), (264, N'Kent Nagano and Orchestre de l''Opéra de Lyon'), (265, N'Julian Bream'), (266, N'Martin Roscoe'), (267, N'Göteborgs Symfoniker & Neeme Järvi'), (268, N'Itzhak Perlman'), (269, N'Michele Campanella'), (270, N'Gerald Moore'), (271, N'Mela Tenenbaum, Pro Musica Prague & Richard Kapp'), (272, N'Emerson String Quartet'), (273, N'C. Monteverdi, Nigel Rogers - Chiaroscuro; London Baroque; London Cornett & Sackbu'), (274, N'Nash Ensemble'), (275, N'Philip Glass Ensemble');

INSERT INTO album (albumid, title, artistid) VALUES (1, N'For Those About To Rock We Salute You', 1), (2, N'Balls to the Wall', 2), (3, N'Restless and Wild', 2), (4, N'Let There Be Rock', 1), (5, N'Big Ones', 3), (6, N'Jagged Little Pill', 4), (7, N'Facelift', 5), (8, N'Warner 25 Anos', 6), (9, N'Plays Metallica By Four Cellos', 7), (10, N'Audioslave', 8), (11, N'Out Of Exile', 8), (12, N'BackBeat Soundtrack', 9), (13, N'The Best Of Billy Cobham', 10), (14, N'Alcohol Fueled Brewtality Live! [Disc 1]', 11), (15, N'Alcohol Fueled Brewtality Live! [Disc 2]', 11), (16, N'Black Sabbath', 12), (17, N'Black Sabbath Vol. 4 (Remaster)', 12), (18, N'Body Count', 13), (19, N'Chemical Wedding', 14), (20, N'The Best Of Buddy Guy - The Millenium Collection', 15), (21, N'Prenda Minha', 16), (22, N'Sozinho Remix Ao Vivo', 16), (23, N'Minha Historia', 17), (24, N'Afrociberdelia', 18), (25, N'Da Lama Ao Caos', 18), (26, N'Acústico MTV [Live]', 19), (27, N'Cidade Negra - Hits', 19), (28, N'Na Pista', 20), (29, N'Axé Bahia 2001', 21), (30, N'BBC Sessions [Disc 1] [Live]', 22), (31, N'Bongo Fury', 23), (32, N'Carnaval 2001', 21), (33, N'Chill: Brazil (Disc 1)', 24), (34, N'Chill: Brazil (Disc 2)', 6), (35, N'Garage Inc. (Disc 1)', 50), (36, N'Greatest Hits II', 51), (37, N'Greatest Kiss', 52), (38, N'Heart of the Night', 53), (39, N'International Superhits', 54), (40, N'Into The Light', 55), (41, N'Meus Momentos', 56), (42, N'Minha História', 57), (43, N'MK III The Final Concerts [Disc 1]', 58), (44, N'Physical Graffiti [Disc 1]', 22), (45, N'Sambas De Enredo 2001', 21), (46, N'Supernatural', 59), (47, N'The Best of Ed Motta', 37), (48, N'The Essential Miles Davis [Disc 1]', 68), (49, N'The Essential Miles Davis [Disc 2]', 68), (50, N'The Final Concerts (Disc 2)', 58), (51, N'Up An'' Atom', 69), (52, N'Vinícius De Moraes - Sem Limite', 70), (53, N'Vozes do MPB', 21), (54, N'Chronicle, Vol. 1', 76), (55, N'Chronicle, Vol. 2', 76), (56, N'Cássia Eller - Coleção Sem Limite [Disc 2]', 77), (57, N'Cássia Eller - Sem Limite [Disc 1]', 77), (58, N'Come Taste The Band', 58), (59, N'Deep Purple In Rock', 58), (60, N'Fireball', 58), (61, N'Knocking at Your Back Door: The Best Of Deep Purple in the 80''s', 58), (62, N'Machine Head', 58), (63, N'Purpendicular', 58), (64, N'Slaves And Masters', 58), (65, N'Stormbringer', 58), (66, N'The Battle Rages On', 58), (67, N'Vault: Def Leppard''s Greatest Hits', 78), (68, N'Outbreak', 79), (69, N'Djavan Ao Vivo - Vol. 02', 80), (70, N'Djavan Ao Vivo - Vol. 1', 80), (71, N'Elis Regina-Minha História', 41), (72, N'The Cream Of Clapton', 81), (73, N'Unplugged', 81), (74, N'Album Of The Year', 82), (75, N'Angel Dust', 82), (76, N'King For A Day Fool For A Lifetime', 82), (77, N'The Real Thing', 82), (78, N'Deixa Entrar', 83), (79, N'In Your Honor [Disc 1]', 84), (80, N'In Your Honor [Disc 2]', 84), (81, N'One By One', 84), (82, N'The Colour And The Shape', 84), (83, N'My Way: The Best Of Frank Sinatra [Disc 1]', 85), (84, N'Roda De Funk', 86), (85, N'As Canções de Eu Tu Eles', 27), (86, N'Quanta Gente Veio Ver (Live)', 27), (87, N'Quanta Gente Veio ver--Bônus De Carnaval', 27), (88, N'Faceless', 87), (89, N'American Idiot', 54), (90, N'Appetite for Destruction', 88), (91, N'Use Your Illusion I', 88), (92, N'Use Your Illusion II', 88), (93, N'Blue Moods', 89), (94, N'A Matter of Life and Death', 90), (95, N'A Real Dead One', 90), (96, N'A Real Live One', 90), (97, N'Brave New World', 90), (98, N'Dance Of Death', 90), (99, N'Fear Of The Dark', 90), (100, N'Iron Maiden', 90), (101, N'Killers', 90), (102, N'Live After Death', 90), (103, N'Live At Donington 1992 (Disc 1)', 90), (104, N'Live At Donington 1992 (Disc 2)', 90), (105, N'No Prayer For The Dying', 90), (106, N'Piece Of Mind', 90), (107, N'Powerslave', 90), (108, N'Rock In Rio [CD1]', 90), (109, N'Rock In Rio [CD2]', 90), (110, N'Seventh Son of a Seventh Son', 90), (111, N'Somewhere in Time', 90), (112, N'The Number of The Beast', 90), (113, N'The X Factor', 90), (114, N'Virtual XI', 90), (115, N'Sex Machine', 91), (116, N'Emergency On Planet Earth', 92), (117, N'Synkronized', 92), (118, N'The Return Of The Space Cowboy', 92), (119, N'Get Born', 93), (120, N'Are You Experienced?', 94), (121, N'Surfing with the Alien (Remastered)', 95), (122, N'Jorge Ben Jor 25 Anos', 46), (123, N'Jota Quest-1995', 96), (124, N'Cafezinho', 97), (125, N'Living After Midnight', 98), (126, N'Unplugged [Live]', 52), (127, N'BBC Sessions [Disc 2] [Live]', 22), (128, N'Coda', 22), (129, N'Houses Of The Holy', 22), (130, N'In Through The Out Door', 22), (131, N'IV', 22), (132, N'Led Zeppelin I', 22), (133, N'Led Zeppelin II', 22), (134, N'Led Zeppelin III', 22), (135, N'Physical Graffiti [Disc 2]', 22), (136, N'Presence', 22), (137, N'The Song Remains The Same (Disc 1)', 22), (138, N'The Song Remains The Same (Disc 2)', 22), (139, N'A TempestadeTempestade Ou O Livro Dos Dias', 99), (140, N'Mais Do Mesmo', 99), (141, N'Greatest Hits', 100), (142, N'Lulu Santos - RCA 100 Anos De Música - Álbum 01', 101), (143, N'Lulu Santos - RCA 100 Anos De Música - Álbum 02', 101), (144, N'Misplaced Childhood', 102), (145, N'Barulhinho Bom', 103), (146, N'Seek And Shall Find: More Of The Best (1963-1981)', 104), (147, N'The Best Of Men At Work', 105), (148, N'Black Album', 50), (149, N'Garage Inc. (Disc 2)', 50), (150, N'Kill ''Em All', 50), (151, N'Load', 50), (152, N'Master Of Puppets', 50), (153, N'ReLoad', 50), (154, N'Ride The Lightning', 50), (155, N'St. Anger', 50), (156, N'...And Justice For All', 50), (157, N'Miles Ahead', 68), (158, N'Milton Nascimento Ao Vivo', 42), (159, N'Minas', 42), (160, N'Ace Of Spades', 106), (161, N'Demorou...', 108), (162, N'Motley Crue Greatest Hits', 109), (163, N'From The Muddy Banks Of The Wishkah [Live]', 110), (164, N'Nevermind', 110), (165, N'Compositores', 111), (166, N'Olodum', 112), (167, N'Acústico MTV', 113), (168, N'Arquivo II', 113), (169, N'Arquivo Os Paralamas Do Sucesso', 113), (170, N'Bark at the Moon (Remastered)', 114), (171, N'Blizzard of Ozz', 114), (172, N'Diary of a Madman (Remastered)', 114), (173, N'No More Tears (Remastered)', 114), (174, N'Tribute', 114), (175, N'Walking Into Clarksdale', 115), (176, N'Original Soundtracks 1', 116), (177, N'The Beast Live', 117), (178, N'Live On Two Legs [Live]', 118), (179, N'Pearl Jam', 118), (180, N'Riot Act', 118), (181, N'Ten', 118), (182, N'Vs.', 118), (183, N'Dark Side Of The Moon', 120), (184, N'Os Cães Ladram Mas A Caravana Não Pára', 121), (185, N'Greatest Hits I', 51), (186, N'News Of The World', 51), (187, N'Out Of Time', 122), (188, N'Green', 124), (189, N'New Adventures In Hi-Fi', 124), (190, N'The Best Of R.E.M.: The IRS Years', 124), (191, N'Cesta Básica', 125), (192, N'Raul Seixas', 126), (193, N'Blood Sugar Sex Magik', 127), (194, N'By The Way', 127), (195, N'Californication', 127), (196, N'Retrospective I (1974-1980)', 128), (197, N'Santana - As Years Go By', 59), (198, N'Santana Live', 59), (199, N'Maquinarama', 130), (200, N'O Samba Poconé', 130), (201, N'Judas 0: B-Sides and Rarities', 131), (202, N'Rotten Apples: Greatest Hits', 131), (203, N'A-Sides', 132), (204, N'Morning Dance', 53), (205, N'In Step', 133), (206, N'Core', 134), (207, N'Mezmerize', 135), (208, N'[1997] Black Light Syndrome', 136), (209, N'Live [Disc 1]', 137), (210, N'Live [Disc 2]', 137), (211, N'The Singles', 138), (212, N'Beyond Good And Evil', 139), (213, N'Pure Cult: The Best Of The Cult (For Rockers, Ravers, Lovers & Sinners) [UK]', 139), (214, N'The Doors', 140), (215, N'The Police Greatest Hits', 141), (216, N'Hot Rocks, 1964-1971 (Disc 1)', 142), (217, N'No Security', 142), (218, N'Voodoo Lounge', 142), (219, N'Tangents', 143), (220, N'Transmission', 143), (221, N'My Generation - The Very Best Of The Who', 144), (222, N'Serie Sem Limite (Disc 1)', 145), (223, N'Serie Sem Limite (Disc 2)', 145), (224, N'Acústico', 146), (225, N'Volume Dois', 146), (226, N'Battlestar Galactica: The Story So Far', 147), (227, N'Battlestar Galactica, Season 3', 147), (228, N'Heroes, Season 1', 148), (229, N'Lost, Season 3', 149), (230, N'Lost, Season 1', 149), (231, N'Lost, Season 2', 149), (232, N'Achtung Baby', 150), (233, N'All That You Can''t Leave Behind', 150), (234, N'B-Sides 1980-1990', 150), (235, N'How To Dismantle An Atomic Bomb', 150), (236, N'Pop', 150), (237, N'Rattle And Hum', 150), (238, N'The Best Of 1980-1990', 150), (239, N'War', 150), (240, N'Zooropa', 150), (241, N'UB40 The Best Of - Volume Two [UK]', 151), (242, N'Diver Down', 152), (243, N'The Best Of Van Halen, Vol. I', 152), (244, N'Van Halen', 152), (245, N'Van Halen III', 152), (246, N'Contraband', 153), (247, N'Vinicius De Moraes', 72), (248, N'Ao Vivo [IMPORT]', 155), (249, N'The Office, Season 1', 156), (250, N'The Office, Season 2', 156), (251, N'The Office, Season 3', 156), (252, N'Un-Led-Ed', 157), (253, N'Battlestar Galactica (Classic), Season 1', 158), (254, N'Aquaman', 159), (255, N'Instant Karma: The Amnesty International Campaign to Save Darfur', 150), (256, N'Speak of the Devil', 114), (257, N'20th Century Masters - The Millennium Collection: The Best of Scorpions', 179), (258, N'House of Pain', 180), (259, N'Radio Brasil (O Som da Jovem Vanguarda) - Seleccao de Henrique Amaro', 36), (260, N'Cake: B-Sides and Rarities', 196), (261, N'LOST, Season 4', 149), (262, N'Quiet Songs', 197), (263, N'Muso Ko', 198), (264, N'Realize', 199), (265, N'Every Kind of Light', 200), (266, N'Duos II', 201), (267, N'Worlds', 202), (268, N'The Best of Beethoven', 203), (269, N'Temple of the Dog', 204), (270, N'Carry On', 205), (271, N'Revelations', 8), (272, N'Adorate Deum: Gregorian Chant from the Proper of the Mass', 206), (273, N'Allegri: Miserere', 207), (274, N'Pachelbel: Canon & Gigue', 208), (275, N'Vivaldi: The Four Seasons', 209), (276, N'Bach: Violin Concertos', 210), (277, N'Bach: Goldberg Variations', 211), (278, N'Bach: The Cello Suites', 212), (279, N'Handel: The Messiah (Highlights)', 213), (280, N'The World of Classical Favourites', 214), (281, N'Sir Neville Marriner: A Celebration', 215), (282, N'Mozart: Wind Concertos', 216), (283, N'Haydn: Symphonies 99 - 104', 217), (284, N'Beethoven: Symhonies Nos. 5 & 6', 218), (285, N'A Soprano Inspired', 219), (286, N'Great Opera Choruses', 220), (287, N'Wagner: Favourite Overtures', 221), (288, N'Fauré: Requiem, Ravel: Pavane & Others', 222), (289, N'Tchaikovsky: The Nutcracker', 223), (290, N'The Last Night of the Proms', 224), (291, N'Puccini: Madama Butterfly - Highlights', 225), (292, N'Holst: The Planets, Op. 32 & Vaughan Williams: Fantasies', 226), (293, N'Pavarotti''s Opera Made Easy', 227), (294, N'Great Performances - Barber''s Adagio and Other Romantic Favorites for Strings', 228), (295, N'Carmina Burana', 229), (296, N'A Copland Celebration, Vol. I', 230), (297, N'Bach: Toccata & Fugue in D Minor', 231), (298, N'Prokofiev: Symphony No.1', 232), (299, N'Scheherazade', 233), (300, N'Bach: The Brandenburg Concertos', 234), (301, N'Chopin: Piano Concertos Nos. 1 & 2', 235), (302, N'Mascagni: Cavalleria Rusticana', 236), (303, N'Sibelius: Finlandia', 237), (304, N'Beethoven Piano Sonatas: Moonlight & Pastorale', 238), (305, N'Great Recordings of the Century - Mahler: Das Lied von der Erde', 240), (306, N'Elgar: Cello Concerto & Vaughan Williams: Fantasias', 241), (307, N'Adams, John: The Chairman Dances', 242), (308, N'Tchaikovsky: 1812 Festival Overture, Op.49, Capriccio Italien & Beethoven: Wellington''s Victory', 243), (309, N'Palestrina: Missa Papae Marcelli & Allegri: Miserere', 244), (310, N'Prokofiev: Romeo & Juliet', 245), (311, N'Strauss: Waltzes', 226), (312, N'Berlioz: Symphonie Fantastique', 245), (313, N'Bizet: Carmen Highlights', 246), (314, N'English Renaissance', 247), (315, N'Handel: Music for the Royal Fireworks (Original Version 1749)', 208), (316, N'Grieg: Peer Gynt Suites & Sibelius: Pelléas et Mélisande', 248), (317, N'Mozart Gala: Famous Arias', 249), (318, N'SCRIABIN: Vers la flamme', 250), (319, N'Armada: Music from the Courts of England and Spain', 251), (320, N'Mozart: Symphonies Nos. 40 & 41', 248), (321, N'Back to Black', 252), (322, N'Frank', 252), (323, N'Carried to Dust (Bonus Track Version)', 253), (324, N'Beethoven: Symphony No. 6 ''Pastoral'' Etc.', 254), (325, N'Bartok: Violin & Viola Concertos', 255), (326, N'Mendelssohn: A Midsummer Night''s Dream', 256), (327, N'Bach: Orchestral Suites Nos. 1 - 4', 257), (328, N'Charpentier: Divertissements, Airs & Concerts', 258), (329, N'South American Getaway', 259), (330, N'Górecki: Symphony No. 3', 260), (331, N'Purcell: The Fairy Queen', 261), (332, N'The Ultimate Relexation Album', 262), (333, N'Purcell: Music for the Queen Mary', 263), (334, N'Weill: The Seven Deadly Sins', 264), (335, N'J.S. Bach: Chaconne, Suite in E Minor, Partita in E Major & Prelude, Fugue and Allegro', 265), (336, N'Prokofiev: Symphony No.5 & Stravinksy: Le Sacre Du Printemps', 248), (337, N'Szymanowski: Piano Works, Vol. 1', 266), (338, N'Nielsen: The Six Symphonies', 267), (339, N'Great Recordings of the Century: Paganini''s 24 Caprices', 268), (340, N'Liszt - 12 Études D''Execution Transcendante', 269), (341, N'Great Recordings of the Century - Shubert: Schwanengesang, 4 Lieder', 270), (342, N'Locatelli: Concertos for Violin, Strings and Continuo, Vol. 3', 271), (343, N'Respighi:Pines of Rome', 226), (344, N'Schubert: The Late String Quartets & String Quintet (3 CD''s)', 272), (345, N'Monteverdi: L''Orfeo', 273), (346, N'Mozart: Chamber Music', 274), (347, N'Koyaanisqatsi (Soundtrack from the Motion Picture)', 275);

INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (1, N'For Those About To Rock (We Salute You)', 1, 1, 1, N'Angus Young, Malcolm Young, Brian Johnson', 343719, 11170334, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (2, N'Balls to the Wall', 2, 2, 1, 342562, 5510424, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (3, N'Fast As a Shark', 3, 2, 1, N'F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffman', 230619, 3990994, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (4, N'Restless and Wild', 3, 2, 1, N'F. Baltes, R.A. Smith-Diesel, S. Kaufman, U. Dirkscneider & W. Hoffman', 252051, 4331779, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (5, N'Princess of the Dawn', 3, 2, 1, N'Deaffy & R.A. Smith-Diesel', 375418, 6290521, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (6, N'Put The Finger On You', 1, 1, 1, N'Angus Young, Malcolm Young, Brian Johnson', 205662, 6713451, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (7, N'Let''s Get It Up', 1, 1, 1, N'Angus Young, Malcolm Young, Brian Johnson', 233926, 7636561, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (8, N'Inject The Venom', 1, 1, 1, N'Angus Young, Malcolm Young, Brian Johnson', 210834, 6852860, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (9, N'Snowballed', 1, 1, 1, N'Angus Young, Malcolm Young, Brian Johnson', 203102, 6599424, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (10, N'Evil Walks', 1, 1, 1, N'Angus Young, Malcolm Young, Brian Johnson', 263497, 8611245, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (11, N'C.O.D.', 1, 1, 1, N'Angus Young, Malcolm Young, Brian Johnson', 199836, 6566314, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (12, N'Breaking The Rules', 1, 1, 1, N'Angus Young, Malcolm Young, Brian Johnson', 263288, 8596840, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (13, N'Night Of The Long Knives', 1, 1, 1, N'Angus Young, Malcolm Young, Brian Johnson', 205688, 6706347, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (14, N'Spellbound', 1, 1, 1, N'Angus Young, Malcolm Young, Brian Johnson', 270863, 8817038, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (15, N'Go Down', 4, 1, 1, N'AC/DC', 331180, 10847611, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (16, N'Dog Eat Dog', 4, 1, 1, N'AC/DC', 215196, 7032162, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (17, N'Let There Be Rock', 4, 1, 1, N'AC/DC', 366654, 12021261, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (18, N'Bad Boy Boogie', 4, 1, 1, N'AC/DC', 267728, 8776140, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (19, N'Problem Child', 4, 1, 1, N'AC/DC', 325041, 10617116, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (20, N'Overdose', 4, 1, 1, N'AC/DC', 369319, 12066294, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (21, N'Hell Ain''t A Bad Place To Be', 4, 1, 1, N'AC/DC', 254380, 8331286, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (22, N'Whole Lotta Rosie', 4, 1, 1, N'AC/DC', 323761, 10547154, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (23, N'Walk On Water', 5, 1, 1, N'Steven Tyler, Joe Perry, Jack Blades, Tommy Shaw', 295680, 9719579, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (24, N'Love In An Elevator', 5, 1, 1, N'Steven Tyler, Joe Perry', 321828, 10552051, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (25, N'Rag Doll', 5, 1, 1, N'Steven Tyler, Joe Perry, Jim Vallance, Holly Knight', 264698, 8675345, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (26, N'What It Takes', 5, 1, 1, N'Steven Tyler, Joe Perry, Desmond Child', 310622, 10144730, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (27, N'Dude (Looks Like A Lady)', 5, 1, 1, N'Steven Tyler, Joe Perry, Desmond Child', 264855, 8679940, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (28, N'Janie''s Got A Gun', 5, 1, 1, N'Steven Tyler, Tom Hamilton', 330736, 10869391, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (29, N'Cryin''', 5, 1, 1, N'Steven Tyler, Joe Perry, Taylor Rhodes', 309263, 10056995, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (30, N'Amazing', 5, 1, 1, N'Steven Tyler, Richie Supa', 356519, 11616195, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (31, N'Blind Man', 5, 1, 1, N'Steven Tyler, Joe Perry, Taylor Rhodes', 240718, 7877453, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (32, N'Deuces Are Wild', 5, 1, 1, N'Steven Tyler, Jim Vallance', 215875, 7074167, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (33, N'The Other Side', 5, 1, 1, N'Steven Tyler, Jim Vallance', 244375, 7983270, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (34, N'Crazy', 5, 1, 1, N'Steven Tyler, Joe Perry, Desmond Child', 316656, 10402398, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (35, N'Eat The Rich', 5, 1, 1, N'Steven Tyler, Joe Perry, Jim Vallance', 251036, 8262039, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (36, N'Angel', 5, 1, 1, N'Steven Tyler, Desmond Child', 307617, 9989331, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (37, N'Livin'' On The Edge', 5, 1, 1, N'Steven Tyler, Joe Perry, Mark Hudson', 381231, 12374569, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (38, N'All I Really Want', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 284891, 9375567, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (39, N'You Oughta Know', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 249234, 8196916, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (40, N'Perfect', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 188133, 6145404, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (41, N'Hand In My Pocket', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 221570, 7224246, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (42, N'Right Through You', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 176117, 5793082, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (43, N'Forgiven', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 300355, 9753256, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (44, N'You Learn', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 239699, 7824837, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (45, N'Head Over Feet', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 267493, 8758008, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (46, N'Mary Jane', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 280607, 9163588, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (47, N'Ironic', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 229825, 7598866, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (48, N'Not The Doctor', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 227631, 7604601, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (49, N'Wake Up', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 293485, 9703359, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (50, N'You Oughta Know (Alternate)', 6, 1, 1, N'Alanis Morissette & Glenn Ballard', 491885, 16008629, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (51, N'We Die Young', 7, 1, 1, N'Jerry Cantrell', 152084, 4925362, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (52, N'Man In The Box', 7, 1, 1, N'Jerry Cantrell, Layne Staley', 286641, 9310272, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (53, N'Sea Of Sorrow', 7, 1, 1, N'Jerry Cantrell', 349831, 11316328, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (54, N'Bleed The Freak', 7, 1, 1, N'Jerry Cantrell', 241946, 7847716, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (55, N'I Can''t Remember', 7, 1, 1, N'Jerry Cantrell, Layne Staley', 222955, 7302550, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (56, N'Love, Hate, Love', 7, 1, 1, N'Jerry Cantrell, Layne Staley', 387134, 12575396, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (57, N'It Ain''t Like That', 7, 1, 1, N'Jerry Cantrell, Michael Starr, Sean Kinney', 277577, 8993793, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (58, N'Sunshine', 7, 1, 1, N'Jerry Cantrell', 284969, 9216057, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (59, N'Put You Down', 7, 1, 1, N'Jerry Cantrell', 196231, 6420530, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (60, N'Confusion', 7, 1, 1, N'Jerry Cantrell, Michael Starr, Layne Staley', 344163, 11183647, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (61, N'I Know Somethin (Bout You)', 7, 1, 1, N'Jerry Cantrell', 261955, 8497788, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (62, N'Real Thing', 7, 1, 1, N'Jerry Cantrell, Layne Staley', 243879, 7937731, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (63, N'Desafinado', 8, 1, 2, 185338, 5990473, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (64, N'Garota De Ipanema', 8, 1, 2, 285048, 9348428, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (65, N'Samba De Uma Nota Só (One Note Samba)', 8, 1, 2, 137273, 4535401, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (66, N'Por Causa De Você', 8, 1, 2, 169900, 5536496, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (67, N'Ligia', 8, 1, 2, 251977, 8226934, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (68, N'Fotografia', 8, 1, 2, 129227, 4198774, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (69, N'Dindi (Dindi)', 8, 1, 2, 253178, 8149148, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (70, N'Se Todos Fossem Iguais A Você (Instrumental)', 8, 1, 2, 134948, 4393377, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (71, N'Falando De Amor', 8, 1, 2, 219663, 7121735, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (72, N'Angela', 8, 1, 2, 169508, 5574957, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (73, N'Corcovado (Quiet Nights Of Quiet Stars)', 8, 1, 2, 205662, 6687994, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (74, N'Outra Vez', 8, 1, 2, 126511, 4110053, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (75, N'O Boto (Bôto)', 8, 1, 2, 366837, 12089673, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (76, N'Canta, Canta Mais', 8, 1, 2, 271856, 8719426, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (77, N'Enter Sandman', 9, 1, 3, N'Apocalyptica', 221701, 7286305, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (78, N'Master Of Puppets', 9, 1, 3, N'Apocalyptica', 436453, 14375310, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (79, N'Harvester Of Sorrow', 9, 1, 3, N'Apocalyptica', 374543, 12372536, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (80, N'The Unforgiven', 9, 1, 3, N'Apocalyptica', 322925, 10422447, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (81, N'Sad But True', 9, 1, 3, N'Apocalyptica', 288208, 9405526, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (82, N'Creeping Death', 9, 1, 3, N'Apocalyptica', 308035, 10110980, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (83, N'Wherever I May Roam', 9, 1, 3, N'Apocalyptica', 369345, 12033110, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (84, N'Welcome Home (Sanitarium)', 9, 1, 3, N'Apocalyptica', 350197, 11406431, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (85, N'Cochise', 10, 1, 1, N'Audioslave/Chris Cornell', 222380, 5339931, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (86, N'Show Me How to Live', 10, 1, 1, N'Audioslave/Chris Cornell', 277890, 6672176, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (87, N'Gasoline', 10, 1, 1, N'Audioslave/Chris Cornell', 279457, 6709793, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (88, N'What You Are', 10, 1, 1, N'Audioslave/Chris Cornell', 249391, 5988186, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (89, N'Like a Stone', 10, 1, 1, N'Audioslave/Chris Cornell', 294034, 7059624, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (90, N'Set It Off', 10, 1, 1, N'Audioslave/Chris Cornell', 263262, 6321091, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (91, N'Shadow on the Sun', 10, 1, 1, N'Audioslave/Chris Cornell', 343457, 8245793, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (92, N'I am the Highway', 10, 1, 1, N'Audioslave/Chris Cornell', 334942, 8041411, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (93, N'Exploder', 10, 1, 1, N'Audioslave/Chris Cornell', 206053, 4948095, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (94, N'Hypnotize', 10, 1, 1, N'Audioslave/Chris Cornell', 206628, 4961887, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (95, N'Bring''em Back Alive', 10, 1, 1, N'Audioslave/Chris Cornell', 329534, 7911634, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (96, N'Light My Way', 10, 1, 1, N'Audioslave/Chris Cornell', 303595, 7289084, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (97, N'Getaway Car', 10, 1, 1, N'Audioslave/Chris Cornell', 299598, 7193162, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (98, N'The Last Remaining Light', 10, 1, 1, N'Audioslave/Chris Cornell', 317492, 7622615, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (99, N'Your Time Has Come', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 255529, 8273592, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (100, N'Out Of Exile', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 291291, 9506571, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (101, N'Be Yourself', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 279484, 9106160, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (102, N'Doesn''t Remind Me', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 255869, 8357387, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (103, N'Drown Me Slowly', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 233691, 7609178, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (104, N'Heaven''s Dead', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 276688, 9006158, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (105, N'The Worm', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 237714, 7710800, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (106, N'Man Or Animal', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 233195, 7542942, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (107, N'Yesterday To Tomorrow', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 273763, 8944205, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (108, N'Dandelion', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 278125, 9003592, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (109, N'#1 Zero', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 299102, 9731988, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (110, N'The Curse', 11, 1, 4, N'Cornell, Commerford, Morello, Wilk', 309786, 10029406, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (111, N'Money', 12, 1, 5, N'Berry Gordy, Jr./Janie Bradford', 147591, 2365897, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (112, N'Long Tall Sally', 12, 1, 5, N'Enotris Johnson/Little Richard/Robert "Bumps" Blackwell', 106396, 1707084, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (113, N'Bad Boy', 12, 1, 5, N'Larry Williams', 116088, 1862126, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (114, N'Twist And Shout', 12, 1, 5, N'Bert Russell/Phil Medley', 161123, 2582553, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (115, N'Please Mr. Postman', 12, 1, 5, N'Brian Holland/Freddie Gorman/Georgia Dobbins/Robert Bateman/William Garrett', 137639, 2206986, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (116, N'C''Mon Everybody', 12, 1, 5, N'Eddie Cochran/Jerry Capehart', 140199, 2247846, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (117, N'Rock ''N'' Roll Music', 12, 1, 5, N'Chuck Berry', 141923, 2276788, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (118, N'Slow Down', 12, 1, 5, N'Larry Williams', 163265, 2616981, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (119, N'Roadrunner', 12, 1, 5, N'Bo Diddley', 143595, 2301989, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (120, N'Carol', 12, 1, 5, N'Chuck Berry', 143830, 2306019, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (121, N'Good Golly Miss Molly', 12, 1, 5, N'Little Richard', 106266, 1704918, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (122, N'20 Flight Rock', 12, 1, 5, N'Ned Fairchild', 107807, 1299960, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (123, N'Quadrant', 13, 1, 2, N'Billy Cobham', 261851, 8538199, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (124, N'Snoopy''s search-Red baron', 13, 1, 2, N'Billy Cobham', 456071, 15075616, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (125, N'Spanish moss-"A sound portrait"-Spanish moss', 13, 1, 2, N'Billy Cobham', 248084, 8217867, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (126, N'Moon germs', 13, 1, 2, N'Billy Cobham', 294060, 9714812, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (127, N'Stratus', 13, 1, 2, N'Billy Cobham', 582086, 19115680, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (128, N'The pleasant pheasant', 13, 1, 2, N'Billy Cobham', 318066, 10630578, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (129, N'Solo-Panhandler', 13, 1, 2, N'Billy Cobham', 246151, 8230661, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (130, N'Do what cha wanna', 13, 1, 2, N'George Duke', 274155, 9018565, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (131, N'Intro/ Low Down', 14, 1, 3, 323683, 10642901, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (132, N'13 Years Of Grief', 14, 1, 3, 246987, 8137421, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (133, N'Stronger Than Death', 14, 1, 3, 300747, 9869647, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (134, N'All For You', 14, 1, 3, 235833, 7726948, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (135, N'Super Terrorizer', 14, 1, 3, 319373, 10513905, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (136, N'Phoney Smile Fake Hellos', 14, 1, 3, 273606, 9011701, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (137, N'Lost My Better Half', 14, 1, 3, 284081, 9355309, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (138, N'Bored To Tears', 14, 1, 3, 247327, 8130090, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (139, N'A.N.D.R.O.T.A.Z.', 14, 1, 3, 266266, 8574746, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (140, N'Born To Booze', 14, 1, 3, 282122, 9257358, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (141, N'World Of Trouble', 14, 1, 3, 359157, 11820932, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (142, N'No More Tears', 14, 1, 3, 555075, 18041629, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (143, N'The Begining... At Last', 14, 1, 3, 365662, 11965109, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (144, N'Heart Of Gold', 15, 1, 3, 194873, 6417460, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (145, N'Snowblind', 15, 1, 3, 420022, 13842549, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (146, N'Like A Bird', 15, 1, 3, 276532, 9115657, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (147, N'Blood In The Wall', 15, 1, 3, 284368, 9359475, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (148, N'The Beginning...At Last', 15, 1, 3, 271960, 8975814, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (149, N'Black Sabbath', 16, 1, 3, 382066, 12440200, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (150, N'The Wizard', 16, 1, 3, 264829, 8646737, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (151, N'Behind The Wall Of Sleep', 16, 1, 3, 217573, 7169049, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (152, N'N.I.B.', 16, 1, 3, 368770, 12029390, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (153, N'Evil Woman', 16, 1, 3, 204930, 6655170, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (154, N'Sleeping Village', 16, 1, 3, 644571, 21128525, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (155, N'Warning', 16, 1, 3, 212062, 6893363, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (156, N'Wheels Of Confusion / The Straightener', 17, 1, 3, N'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 494524, 16065830, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (157, N'Tomorrow''s Dream', 17, 1, 3, N'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 192496, 6252071, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (158, N'Changes', 17, 1, 3, N'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 286275, 9175517, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (159, N'FX', 17, 1, 3, N'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 103157, 3331776, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (160, N'Supernaut', 17, 1, 3, N'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 285779, 9245971, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (161, N'Snowblind', 17, 1, 3, N'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 331676, 10813386, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (162, N'Cornucopia', 17, 1, 3, N'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 234814, 7653880, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (163, N'Laguna Sunrise', 17, 1, 3, N'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 173087, 5671374, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (164, N'St. Vitus Dance', 17, 1, 3, N'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 149655, 4884969, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (165, N'Under The Sun/Every Day Comes and Goes', 17, 1, 3, N'Tony Iommi, Bill Ward, Geezer Butler, Ozzy Osbourne', 350458, 11360486, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (166, N'Smoked Pork', 18, 1, 4, 47333, 1549074, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (167, N'Body Count''s In The House', 18, 1, 4, 204251, 6715413, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (168, N'Now Sports', 18, 1, 4, 4884, 161266, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (169, N'Body Count', 18, 1, 4, 317936, 10489139, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (170, N'A Statistic', 18, 1, 4, 6373, 211997, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (171, N'Bowels Of The Devil', 18, 1, 4, 223216, 7324125, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (172, N'The Real Problem', 18, 1, 4, 11650, 387360, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (173, N'KKK Bitch', 18, 1, 4, 173008, 5709631, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (174, N'D Note', 18, 1, 4, 95738, 3067064, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (175, N'Voodoo', 18, 1, 4, 300721, 9875962, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (176, N'The Winner Loses', 18, 1, 4, 392254, 12843821, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (177, N'There Goes The Neighborhood', 18, 1, 4, 350171, 11443471, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (178, N'Oprah', 18, 1, 4, 6635, 224313, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (179, N'Evil Dick', 18, 1, 4, 239020, 7828873, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (180, N'Body Count Anthem', 18, 1, 4, 166426, 5463690, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (181, N'Momma''s Gotta Die Tonight', 18, 1, 4, 371539, 12122946, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (182, N'Freedom Of Speech', 18, 1, 4, 281234, 9337917, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (183, N'King In Crimson', 19, 1, 3, N'Roy Z', 283167, 9218499, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (184, N'Chemical Wedding', 19, 1, 3, N'Roy Z', 246177, 8022764, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (185, N'The Tower', 19, 1, 3, N'Roy Z', 285257, 9435693, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (186, N'Killing Floor', 19, 1, 3, N'Adrian Smith', 269557, 8854240, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (187, N'Book Of Thel', 19, 1, 3, N'Eddie Casillas/Roy Z', 494393, 16034404, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (188, N'Gates Of Urizen', 19, 1, 3, N'Roy Z', 265351, 8627004, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (189, N'Jerusalem', 19, 1, 3, N'Roy Z', 402390, 13194463, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (190, N'Trupets Of Jericho', 19, 1, 3, N'Roy Z', 359131, 11820908, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (191, N'Machine Men', 19, 1, 3, N'Adrian Smith', 341655, 11138147, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (192, N'The Alchemist', 19, 1, 3, N'Roy Z', 509413, 16545657, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (193, N'Realword', 19, 1, 3, N'Roy Z', 237531, 7802095, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (194, N'First Time I Met The Blues', 20, 1, 6, N'Eurreal Montgomery', 140434, 4604995, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (195, N'Let Me Love You Baby', 20, 1, 6, N'Willie Dixon', 175386, 5716994, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (196, N'Stone Crazy', 20, 1, 6, N'Buddy Guy', 433397, 14184984, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (197, N'Pretty Baby', 20, 1, 6, N'Willie Dixon', 237662, 7848282, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (198, N'When My Left Eye Jumps', 20, 1, 6, N'Al Perkins/Willie Dixon', 235311, 7685363, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (199, N'Leave My Girl Alone', 20, 1, 6, N'Buddy Guy', 204721, 6859518, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (200, N'She Suits Me To A Tee', 20, 1, 6, N'Buddy Guy', 136803, 4456321, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (201, N'Keep It To Myself (Aka Keep It To Yourself)', 20, 1, 6, N'Sonny Boy Williamson [I]', 166060, 5487056, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (202, N'My Time After Awhile', 20, 1, 6, N'Robert Geddins/Ron Badger/Sheldon Feinberg', 182491, 6022698, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (203, N'Too Many Ways (Alternate)', 20, 1, 6, N'Willie Dixon', 135053, 4459946, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (204, N'Talkin'' ''Bout Women Obviously', 20, 1, 6, N'Amos Blakemore/Buddy Guy', 589531, 19161377, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (205, N'Jorge Da Capadócia', 21, 1, 7, N'Jorge Ben', 177397, 5842196, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (206, N'Prenda Minha', 21, 1, 7, N'Tradicional', 99369, 3225364, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (207, N'Meditação', 21, 1, 7, N'Tom Jobim - Newton Mendoça', 148793, 4865597, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (208, N'Terra', 21, 1, 7, N'Caetano Veloso', 482429, 15889054, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (209, N'Eclipse Oculto', 21, 1, 7, N'Caetano Veloso', 221936, 7382703, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (210, N'Texto "Verdade Tropical"', 21, 1, 7, N'Caetano Veloso', 84088, 2752161, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (211, N'Bem Devagar', 21, 1, 7, N'Gilberto Gil', 133172, 4333651, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (212, N'Drão', 21, 1, 7, N'Gilberto Gil', 156264, 5065932, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (213, N'Saudosismo', 21, 1, 7, N'Caetano Veloso', 144326, 4726981, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (214, N'Carolina', 21, 1, 7, N'Chico Buarque', 181812, 5924159, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (215, N'Sozinho', 21, 1, 7, N'Peninha', 190589, 6253200, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (216, N'Esse Cara', 21, 1, 7, N'Caetano Veloso', 223111, 7217126, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (217, N'Mel', 21, 1, 7, N'Caetano Veloso - Waly Salomão', 294765, 9854062, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (218, N'Linha Do Equador', 21, 1, 7, N'Caetano Veloso - Djavan', 299337, 10003747, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (219, N'Odara', 21, 1, 7, N'Caetano Veloso', 141270, 4704104, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (220, N'A Luz De Tieta', 21, 1, 7, N'Caetano Veloso', 251742, 8507446, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (221, N'Atrás Da Verd-E-Rosa Só Não Vai Quem Já Morreu', 21, 1, 7, N'David Corrêa - Paulinho Carvalho - Carlos Sena - Bira do Ponto', 307252, 10364247, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (222, N'Vida Boa', 21, 1, 7, N'Fausto Nilo - Armandinho', 281730, 9411272, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (223, N'Sozinho (Hitmakers Classic Mix)', 22, 1, 7, 436636, 14462072, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (224, N'Sozinho (Hitmakers Classic Radio Edit)', 22, 1, 7, 195004, 6455134, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (225, N'Sozinho (Caêdrum ''n'' Bass)', 22, 1, 7, 328071, 10975007, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (226, N'Carolina', 23, 1, 7, 163056, 5375395, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (227, N'Essa Moça Ta Diferente', 23, 1, 7, 167235, 5568574, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (228, N'Vai Passar', 23, 1, 7, 369763, 12359161, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (229, N'Samba De Orly', 23, 1, 7, 162429, 5431854, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (230, N'Bye, Bye Brasil', 23, 1, 7, 283402, 9499590, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (231, N'Atras Da Porta', 23, 1, 7, 189675, 6132843, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (232, N'Tatuagem', 23, 1, 7, 172120, 5645703, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (233, N'O Que Será (À Flor Da Terra)', 23, 1, 7, 167288, 5574848, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (234, N'Morena De Angola', 23, 1, 7, 186801, 6373932, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (235, N'Apesar De Você', 23, 1, 7, 234501, 7886937, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (236, N'A Banda', 23, 1, 7, 132493, 4349539, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (237, N'Minha Historia', 23, 1, 7, 182256, 6029673, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (238, N'Com Açúcar E Com Afeto', 23, 1, 7, 175386, 5846442, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (239, N'Brejo Da Cruz', 23, 1, 7, 214099, 7270749, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (240, N'Meu Caro Amigo', 23, 1, 7, 260257, 8778172, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (241, N'Geni E O Zepelim', 23, 1, 7, 317570, 10342226, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (242, N'Trocando Em Miúdos', 23, 1, 7, 169717, 5461468, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (243, N'Vai Trabalhar Vagabundo', 23, 1, 7, 139154, 4693941, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (244, N'Gota D''água', 23, 1, 7, 153208, 5074189, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (245, N'Construção / Deus Lhe Pague', 23, 1, 7, 383059, 12675305, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (246, N'Mateus Enter', 24, 1, 7, N'Chico Science', 33149, 1103013, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (247, N'O Cidadão Do Mundo', 24, 1, 7, N'Chico Science', 200933, 6724966, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (248, N'Etnia', 24, 1, 7, N'Chico Science', 152555, 5061413, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (249, N'Quilombo Groove [Instrumental]', 24, 1, 7, N'Chico Science', 151823, 5042447, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (250, N'Macô', 24, 1, 7, N'Chico Science', 249600, 8253934, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (251, N'Um Passeio No Mundo Livre', 24, 1, 7, N'Chico Science', 240091, 7984291, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (252, N'Samba Do Lado', 24, 1, 7, N'Chico Science', 227317, 7541688, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (253, N'Maracatu Atômico', 24, 1, 7, N'Chico Science', 284264, 9670057, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (254, N'O Encontro De Isaac Asimov Com Santos Dumont No Céu', 24, 1, 7, N'Chico Science', 99108, 3240816, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (255, N'Corpo De Lama', 24, 1, 7, N'Chico Science', 232672, 7714954, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (256, N'Sobremesa', 24, 1, 7, N'Chico Science', 240091, 7960868, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (257, N'Manguetown', 24, 1, 7, N'Chico Science', 194560, 6475159, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (258, N'Um Satélite Na Cabeça', 24, 1, 7, N'Chico Science', 126615, 4272821, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (259, N'Baião Ambiental [Instrumental]', 24, 1, 7, N'Chico Science', 152659, 5198539, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (260, N'Sangue De Bairro', 24, 1, 7, N'Chico Science', 132231, 4415557, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (261, N'Enquanto O Mundo Explode', 24, 1, 7, N'Chico Science', 88764, 2968650, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (262, N'Interlude Zumbi', 24, 1, 7, N'Chico Science', 71627, 2408550, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (263, N'Criança De Domingo', 24, 1, 7, N'Chico Science', 208222, 6984813, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (264, N'Amor De Muito', 24, 1, 7, N'Chico Science', 175333, 5881293, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (265, N'Samidarish [Instrumental]', 24, 1, 7, N'Chico Science', 272431, 8911641, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (266, N'Maracatu Atômico [Atomic Version]', 24, 1, 7, N'Chico Science', 273084, 9019677, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (267, N'Maracatu Atômico [Ragga Mix]', 24, 1, 7, N'Chico Science', 210155, 6986421, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (268, N'Maracatu Atômico [Trip Hop]', 24, 1, 7, N'Chico Science', 221492, 7380787, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (269, N'Banditismo Por Uma Questa', 25, 1, 7, 307095, 10251097, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (270, N'Banditismo Por Uma Questa', 25, 1, 7, 243644, 8147224, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (271, N'Rios Pontes & Overdrives', 25, 1, 7, 286720, 9659152, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (272, N'Cidade', 25, 1, 7, 216346, 7241817, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (273, N'Praiera', 25, 1, 7, 183640, 6172781, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (274, N'Samba Makossa', 25, 1, 7, 271856, 9095410, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (275, N'Da Lama Ao Caos', 25, 1, 7, 251559, 8378065, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (276, N'Maracatu De Tiro Certeiro', 25, 1, 7, 88868, 2901397, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (277, N'Salustiano Song', 25, 1, 7, 215405, 7183969, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (278, N'Antene Se', 25, 1, 7, 248372, 8253618, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (279, N'Risoflora', 25, 1, 7, 105586, 3536938, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (280, N'Lixo Do Mangue', 25, 1, 7, 193253, 6534200, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (281, N'Computadores Fazem Arte', 25, 1, 7, 404323, 13702771, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (282, N'Girassol', 26, 1, 8, N'Bino Farias/Da Gama/Lazão/Pedro Luis/Toni Garrido', 249808, 8327676, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (283, N'A Sombra Da Maldade', 26, 1, 8, N'Da Gama/Toni Garrido', 230922, 7697230, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (284, N'Johnny B. Goode', 26, 1, 8, N'Chuck Berry', 254615, 8505985, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (285, N'Soldado Da Paz', 26, 1, 8, N'Herbert Vianna', 194220, 6455080, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (286, N'Firmamento', 26, 1, 8, N'Bino Farias/Da Gama/Henry Lawes/Lazão/Toni Garrido/Winston Foser-Vers', 222145, 7402658, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (287, N'Extra', 26, 1, 8, N'Gilberto Gil', 304352, 10078050, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (288, N'O Erê', 26, 1, 8, N'Bernardo Vilhena/Bino Farias/Da Gama/Lazão/Toni Garrido', 236382, 7866924, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (289, N'Podes Crer', 26, 1, 8, N'Bino Farias/Da Gama/Lazão/Toni Garrido', 232280, 7747747, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (290, N'A Estrada', 26, 1, 8, N'Bino Farias/Da Gama/Lazão/Toni Garrido', 248842, 8275673, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (291, N'Berlim', 26, 1, 8, N'Da Gama/Toni Garrido', 207542, 6920424, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (292, N'Já Foi', 26, 1, 8, N'Bino Farias/Da Gama/Lazão/Toni Garrido', 221544, 7388466, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (293, N'Onde Você Mora?', 26, 1, 8, N'Marisa Monte/Nando Reis', 256026, 8502588, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (294, N'Pensamento', 26, 1, 8, N'Bino Farias/Da Gamma/Lazão/Rás Bernard', 173008, 5748424, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (295, N'Conciliação', 26, 1, 8, N'Da Gama/Lazão/Rás Bernardo', 257619, 8552474, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (296, N'Realidade Virtual', 26, 1, 8, N'Bino Farias/Da Gama/Lazão/Toni Garrido', 195239, 6503533, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (297, N'Mensagem', 26, 1, 8, N'Bino Farias/Da Gama/Lazão/Rás Bernardo', 225332, 7488852, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (298, N'A Cor Do Sol', 26, 1, 8, N'Bernardo Vilhena/Da Gama/Lazão', 231392, 7663348, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (299, N'Onde Você Mora?', 27, 1, 8, N'Marisa Monte/Nando Reis', 298396, 10056970, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (300, N'O Erê', 27, 1, 8, N'Bernardo Vilhena/Bino/Da Gama/Lazao/Toni Garrido', 206942, 6950332, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (301, N'A Sombra Da Maldade', 27, 1, 8, N'Da Gama/Toni Garrido', 285231, 9544383, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (302, N'A Estrada', 27, 1, 8, N'Da Gama/Lazao/Toni Garrido', 282174, 9344477, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (303, N'Falar A Verdade', 27, 1, 8, N'Bino/Da Gama/Ras Bernardo', 244950, 8189093, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (304, N'Firmamento', 27, 1, 8, N'Harry Lawes/Winston Foster-Vers', 225488, 7507866, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (305, N'Pensamento', 27, 1, 8, N'Bino/Da Gama/Ras Bernardo', 192391, 6399761, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (306, N'Realidade Virtual', 27, 1, 8, N'Bino/Da Gamma/Lazao/Toni Garrido', 240300, 8069934, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (307, N'Doutor', 27, 1, 8, N'Bino/Da Gama/Toni Garrido', 178155, 5950952, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (308, N'Na Frente Da TV', 27, 1, 8, N'Bino/Da Gama/Lazao/Ras Bernardo', 289750, 9633659, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (309, N'Downtown', 27, 1, 8, N'Cidade Negra', 239725, 8024386, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (310, N'Sábado A Noite', 27, 1, 8, N'Lulu Santos', 267363, 8895073, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (311, N'A Cor Do Sol', 27, 1, 8, N'Bernardo Vilhena/Da Gama/Lazao', 273031, 9142937, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (312, N'Eu Também Quero Beijar', 27, 1, 8, N'Fausto Nilo/Moraes Moreira/Pepeu Gomes', 211147, 7029400, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (313, N'Noite Do Prazer', 28, 1, 7, 311353, 10309980, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (314, N'À Francesa', 28, 1, 7, 244532, 8150846, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (315, N'Cada Um Cada Um (A Namoradeira)', 28, 1, 7, 253492, 8441034, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (316, N'Linha Do Equador', 28, 1, 7, 244715, 8123466, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (317, N'Amor Demais', 28, 1, 7, 254040, 8420093, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (318, N'Férias', 28, 1, 7, 264202, 8731945, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (319, N'Gostava Tanto De Você', 28, 1, 7, 230452, 7685326, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (320, N'Flor Do Futuro', 28, 1, 7, 275748, 9205941, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (321, N'Felicidade Urgente', 28, 1, 7, 266605, 8873358, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (322, N'Livre Pra Viver', 28, 1, 7, 214595, 7111596, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (323, N'Dig-Dig, Lambe-Lambe (Ao Vivo)', 29, 1, 9, N'Cassiano Costa/Cintia Maviane/J.F./Lucas Costa', 205479, 6892516, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (324, N'Pererê', 29, 1, 9, N'Augusto Conceição/Chiclete Com Banana', 198661, 6643207, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (325, N'TriboTchan', 29, 1, 9, N'Cal Adan/Paulo Levi', 194194, 6507950, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (326, N'Tapa Aqui, Descobre Ali', 29, 1, 9, N'Paulo Levi/W. Rangel', 188630, 6327391, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (327, N'Daniela', 29, 1, 9, N'Jorge Cardoso/Pierre Onasis', 230791, 7748006, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (328, N'Bate Lata', 29, 1, 9, N'Fábio Nolasco/Gal Sales/Ivan Brasil', 206733, 7034985, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (329, N'Garotas do Brasil', 29, 1, 9, N'Garay, Ricardo Engels/Luca Predabom/Ludwig, Carlos Henrique/Maurício Vieira', 210155, 6973625, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (330, N'Levada do Amor (Ailoviu)', 29, 1, 9, N'Luiz Wanderley/Paulo Levi', 190093, 6457752, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (331, N'Lavadeira', 29, 1, 9, N'Do Vale, Valverde/Gal Oliveira/Luciano Pinto', 214256, 7254147, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (332, N'Reboladeira', 29, 1, 9, N'Cal Adan/Ferrugem/Julinho Carioca/Tríona Ní Dhomhnaill', 210599, 7027525, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (333, N'É que Nessa Encarnação Eu Nasci Manga', 29, 1, 9, N'Lucina/Luli', 196519, 6568081, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (334, N'Reggae Tchan', 29, 1, 9, N'Cal Adan/Del Rey, Tension/Edu Casanova', 206654, 6931328, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (335, N'My Love', 29, 1, 9, N'Jauperi/Zeu Góes', 203493, 6772813, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (336, N'Latinha de Cerveja', 29, 1, 9, N'Adriano Bernandes/Edmar Neves', 166687, 5532564, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (337, N'You Shook Me', 30, 1, 1, N'J B Lenoir/Willie Dixon', 315951, 10249958, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (338, N'I Can''t Quit You Baby', 30, 1, 1, N'Willie Dixon', 263836, 8581414, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (339, N'Communication Breakdown', 30, 1, 1, N'Jimmy Page/John Bonham/John Paul Jones', 192653, 6287257, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (340, N'Dazed and Confused', 30, 1, 1, N'Jimmy Page', 401920, 13035765, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (341, N'The Girl I Love She Got Long Black Wavy Hair', 30, 1, 1, N'Jimmy Page/John Bonham/John Estes/John Paul Jones/Robert Plant', 183327, 5995686, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (342, N'What is and Should Never Be', 30, 1, 1, N'Jimmy Page/Robert Plant', 260675, 8497116, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (343, N'Communication Breakdown(2)', 30, 1, 1, N'Jimmy Page/John Bonham/John Paul Jones', 161149, 5261022, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (344, N'Travelling Riverside Blues', 30, 1, 1, N'Jimmy Page/Robert Johnson/Robert Plant', 312032, 10232581, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (345, N'Whole Lotta Love', 30, 1, 1, N'Jimmy Page/John Bonham/John Paul Jones/Robert Plant/Willie Dixon', 373394, 12258175, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (346, N'Somethin'' Else', 30, 1, 1, N'Bob Cochran/Sharon Sheeley', 127869, 4165650, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (347, N'Communication Breakdown(3)', 30, 1, 1, N'Jimmy Page/John Bonham/John Paul Jones', 185260, 6041133, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (348, N'I Can''t Quit You Baby(2)', 30, 1, 1, N'Willie Dixon', 380551, 12377615, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (349, N'You Shook Me(2)', 30, 1, 1, N'J B Lenoir/Willie Dixon', 619467, 20138673, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (350, N'How Many More Times', 30, 1, 1, N'Chester Burnett/Jimmy Page/John Bonham/John Paul Jones/Robert Plant', 711836, 23092953, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (351, N'Debra Kadabra', 31, 1, 1, N'Frank Zappa', 234553, 7649679, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (352, N'Carolina Hard-Core Ecstasy', 31, 1, 1, N'Frank Zappa', 359680, 11731061, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (353, N'Sam With The Showing Scalp Flat Top', 31, 1, 1, N'Don Van Vliet', 171284, 5572993, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (354, N'Poofter''s Froth Wyoming Plans Ahead', 31, 1, 1, N'Frank Zappa', 183902, 6007019, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (355, N'200 Years Old', 31, 1, 1, N'Frank Zappa', 272561, 8912465, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (356, N'Cucamonga', 31, 1, 1, N'Frank Zappa', 144483, 4728586, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (357, N'Advance Romance', 31, 1, 1, N'Frank Zappa', 677694, 22080051, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (358, N'Man With The Woman Head', 31, 1, 1, N'Don Van Vliet', 88894, 2922044, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (359, N'Muffin Man', 31, 1, 1, N'Frank Zappa', 332878, 10891682, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (360, N'Vai-Vai 2001', 32, 1, 10, 276349, 9402241, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (361, N'X-9 2001', 32, 1, 10, 273920, 9310370, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (362, N'Gavioes 2001', 32, 1, 10, 282723, 9616640, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (363, N'Nene 2001', 32, 1, 10, 284969, 9694508, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (364, N'Rosas De Ouro 2001', 32, 1, 10, 284342, 9721084, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (365, N'Mocidade Alegre 2001', 32, 1, 10, 282488, 9599937, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (366, N'Camisa Verde 2001', 32, 1, 10, 283454, 9633755, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (367, N'Leandro De Itaquera 2001', 32, 1, 10, 274808, 9451845, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (368, N'Tucuruvi 2001', 32, 1, 10, 287921, 9883335, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (369, N'Aguia De Ouro 2001', 32, 1, 10, 284160, 9698729, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (370, N'Ipiranga 2001', 32, 1, 10, 248293, 8522591, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (371, N'Morro Da Casa Verde 2001', 32, 1, 10, 284708, 9718778, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (372, N'Perola Negra 2001', 32, 1, 10, 281626, 9619196, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (373, N'Sao Lucas 2001', 32, 1, 10, 296254, 10020122, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (374, N'Guanabara', 33, 1, 7, N'Marcos Valle', 247614, 8499591, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (375, N'Mas Que Nada', 33, 1, 7, N'Jorge Ben', 248398, 8255254, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (376, N'Vôo Sobre o Horizonte', 33, 1, 7, N'J.r.Bertami/Parana', 225097, 7528825, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (377, N'A Paz', 33, 1, 7, N'Donato/Gilberto Gil', 263183, 8619173, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (378, N'Wave (Vou te Contar)', 33, 1, 7, N'Antonio Carlos Jobim', 271647, 9057557, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (379, N'Água de Beber', 33, 1, 7, N'Antonio Carlos Jobim/Vinicius de Moraes', 146677, 4866476, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (380, N'Samba da Bençaco', 33, 1, 7, N'Baden Powell/Vinicius de Moraes', 282200, 9440676, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (381, N'Pode Parar', 33, 1, 7, N'Jorge Vercilo/Jota Maranhao', 179408, 6046678, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (382, N'Menino do Rio', 33, 1, 7, N'Caetano Veloso', 262713, 8737489, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (383, N'Ando Meio Desligado', 33, 1, 7, N'Caetano Veloso', 195813, 6547648, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (384, N'Mistério da Raça', 33, 1, 7, N'Luiz Melodia/Ricardo Augusto', 184320, 6191752, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (385, N'All Star', 33, 1, 7, N'Nando Reis', 176326, 5891697, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (386, N'Menina Bonita', 33, 1, 7, N'Alexandre Brazil/Pedro Luis/Rodrigo Cabelo', 237087, 7938246, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (387, N'Pescador de Ilusões', 33, 1, 7, N'Macelo Yuka/O Rappa', 245524, 8267067, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (388, N'À Vontade (Live Mix)', 33, 1, 7, N'Bombom/Ed Motta', 180636, 5972430, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (389, N'Maria Fumaça', 33, 1, 7, N'Luiz Carlos/Oberdan', 141008, 4743149, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (390, N'Sambassim (dj patife remix)', 33, 1, 7, N'Alba Carvalho/Fernando Porto', 213655, 7243166, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (391, N'Garota De Ipanema', 34, 1, 7, N'Vários', 279536, 9141343, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (392, N'Tim Tim Por Tim Tim', 34, 1, 7, N'Vários', 213237, 7143328, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (393, N'Tarde Em Itapoã', 34, 1, 7, N'Vários', 313704, 10344491, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (394, N'Tanto Tempo', 34, 1, 7, N'Vários', 170292, 5572240, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (395, N'Eu Vim Da Bahia - Live', 34, 1, 7, N'Vários', 157988, 5115428, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (396, N'Alô Alô Marciano', 34, 1, 7, N'Vários', 238106, 8013065, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (397, N'Linha Do Horizonte', 34, 1, 7, N'Vários', 279484, 9275929, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (398, N'Only A Dream In Rio', 34, 1, 7, N'Vários', 371356, 12192989, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (399, N'Abrir A Porta', 34, 1, 7, N'Vários', 271960, 8991141, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (400, N'Alice', 34, 1, 7, N'Vários', 165982, 5594341, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (401, N'Momentos Que Marcam', 34, 1, 7, N'Vários', 280137, 9313740, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (402, N'Um Jantar Pra Dois', 34, 1, 7, N'Vários', 237714, 7819755, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (403, N'Bumbo Da Mangueira', 34, 1, 7, N'Vários', 270158, 9073350, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (404, N'Mr Funk Samba', 34, 1, 7, N'Vários', 213890, 7102545, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (405, N'Santo Antonio', 34, 1, 7, N'Vários', 162716, 5492069, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (406, N'Por Você', 34, 1, 7, N'Vários', 205557, 6792493, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (407, N'Só Tinha De Ser Com Você', 34, 1, 7, N'Vários', 389642, 13085596, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (408, N'Free Speech For The Dumb', 35, 1, 3, N'Molaney/Morris/Roberts/Wainwright', 155428, 5076048, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (409, N'It''s Electric', 35, 1, 3, N'Harris/Tatler', 213995, 6978601, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (410, N'Sabbra Cadabra', 35, 1, 3, N'Black Sabbath', 380342, 12418147, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (411, N'Turn The Page', 35, 1, 3, N'Seger', 366524, 11946327, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (412, N'Die Die My Darling', 35, 1, 3, N'Danzig', 149315, 4867667, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (413, N'Loverman', 35, 1, 3, N'Cave', 472764, 15446975, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (414, N'Mercyful Fate', 35, 1, 3, N'Diamond/Shermann', 671712, 21942829, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (415, N'Astronomy', 35, 1, 3, N'A.Bouchard/J.Bouchard/S.Pearlman', 397531, 13065612, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (416, N'Whiskey In The Jar', 35, 1, 3, N'Traditional', 305005, 9943129, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (417, N'Tuesday''s Gone', 35, 1, 3, N'Collins/Van Zandt', 545750, 17900787, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (418, N'The More I See', 35, 1, 3, N'Molaney/Morris/Roberts/Wainwright', 287973, 9378873, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (419, N'A Kind Of Magic', 36, 1, 1, N'Roger Taylor', 262608, 8689618, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (420, N'Under Pressure', 36, 1, 1, N'Queen & David Bowie', 236617, 7739042, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (421, N'Radio GA GA', 36, 1, 1, N'Roger Taylor', 343745, 11358573, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (422, N'I Want It All', 36, 1, 1, N'Queen', 241684, 7876564, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (423, N'I Want To Break Free', 36, 1, 1, N'John Deacon', 259108, 8552861, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (424, N'Innuendo', 36, 1, 1, N'Queen', 387761, 12664591, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (425, N'It''s A Hard Life', 36, 1, 1, N'Freddie Mercury', 249417, 8112242, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (426, N'Breakthru', 36, 1, 1, N'Queen', 249234, 8150479, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (427, N'Who Wants To Live Forever', 36, 1, 1, N'Brian May', 297691, 9577577, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (428, N'Headlong', 36, 1, 1, N'Queen', 273057, 8921404, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (429, N'The Miracle', 36, 1, 1, N'Queen', 294974, 9671923, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (430, N'I''m Going Slightly Mad', 36, 1, 1, N'Queen', 248032, 8192339, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (431, N'The Invisible Man', 36, 1, 1, N'Queen', 238994, 7920353, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (432, N'Hammer To Fall', 36, 1, 1, N'Brian May', 220316, 7255404, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (433, N'Friends Will Be Friends', 36, 1, 1, N'Freddie Mercury & John Deacon', 248920, 8114582, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (434, N'The Show Must Go On', 36, 1, 1, N'Queen', 263784, 8526760, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (435, N'One Vision', 36, 1, 1, N'Queen', 242599, 7936928, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (436, N'Detroit Rock City', 37, 1, 1, N'Paul Stanley, B. Ezrin', 218880, 7146372, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (437, N'Black Diamond', 37, 1, 1, N'Paul Stanley', 314148, 10266007, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (438, N'Hard Luck Woman', 37, 1, 1, N'Paul Stanley', 216032, 7109267, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (439, N'Sure Know Something', 37, 1, 1, N'Paul Stanley, Vincent Poncia', 242468, 7939886, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (440, N'Love Gun', 37, 1, 1, N'Paul Stanley', 196257, 6424915, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (441, N'Deuce', 37, 1, 1, N'Gene Simmons', 185077, 6097210, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (442, N'Goin'' Blind', 37, 1, 1, N'Gene Simmons, S. Coronel', 216215, 7045314, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (443, N'Shock Me', 37, 1, 1, N'Ace Frehley', 227291, 7529336, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (444, N'Do You Love Me', 37, 1, 1, N'Paul Stanley, B. Ezrin, K. Fowley', 214987, 6976194, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (445, N'She', 37, 1, 1, N'Gene Simmons, S. Coronel', 248346, 8229734, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (446, N'I Was Made For Loving You', 37, 1, 1, N'Paul Stanley, Vincent Poncia, Desmond Child', 271360, 9018078, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (447, N'Shout It Out Loud', 37, 1, 1, N'Paul Stanley, Gene Simmons, B. Ezrin', 219742, 7194424, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (448, N'God Of Thunder', 37, 1, 1, N'Paul Stanley', 255791, 8309077, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (449, N'Calling Dr. Love', 37, 1, 1, N'Gene Simmons', 225332, 7395034, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (450, N'Beth', 37, 1, 1, N'S. Penridge, Bob Ezrin, Peter Criss', 166974, 5360574, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (451, N'Strutter', 37, 1, 1, N'Paul Stanley, Gene Simmons', 192496, 6317021, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (452, N'Rock And Roll All Nite', 37, 1, 1, N'Paul Stanley, Gene Simmons', 173609, 5735902, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (453, N'Cold Gin', 37, 1, 1, N'Ace Frehley', 262243, 8609783, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (454, N'Plaster Caster', 37, 1, 1, N'Gene Simmons', 207333, 6801116, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (455, N'God Gave Rock ''n'' Roll To You', 37, 1, 1, N'Paul Stanley, Gene Simmons, Rus Ballard, Bob Ezrin', 320444, 10441590, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (456, N'Heart of the Night', 38, 1, 2, 273737, 9098263, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (457, N'De La Luz', 38, 1, 2, 315219, 10518284, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (458, N'Westwood Moon', 38, 1, 2, 295627, 9765802, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (459, N'Midnight', 38, 1, 2, 266866, 8851060, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (460, N'Playtime', 38, 1, 2, 273580, 9070880, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (461, N'Surrender', 38, 1, 2, 287634, 9422926, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (462, N'Valentino''s', 38, 1, 2, 296124, 9848545, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (463, N'Believe', 38, 1, 2, 310778, 10317185, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (464, N'As We Sleep', 38, 1, 2, 316865, 10429398, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (465, N'When Evening Falls', 38, 1, 2, 298135, 9863942, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (466, N'J Squared', 38, 1, 2, 288757, 9480777, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (467, N'Best Thing', 38, 1, 2, 274259, 9069394, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (468, N'Maria', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 167262, 5484747, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (469, N'Poprocks And Coke', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 158354, 5243078, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (470, N'Longview', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 234083, 7714939, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (471, N'Welcome To Paradise', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 224208, 7406008, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (472, N'Basket Case', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 181629, 5951736, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (473, N'When I Come Around', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 178364, 5839426, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (474, N'She', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 134164, 4425128, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (475, N'J.A.R. (Jason Andrew Relva)', 39, 1, 4, N'Mike Dirnt -Words Green Day -Music', 170997, 5645755, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (476, N'Geek Stink Breath', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 135888, 4408983, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (477, N'Brain Stew', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 193149, 6305550, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (478, N'Jaded', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 90331, 2950224, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (479, N'Walking Contradiction', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 151170, 4932366, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (480, N'Stuck With Me', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 135523, 4431357, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (481, N'Hitchin'' A Ride', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 171546, 5616891, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (482, N'Good Riddance (Time Of Your Life)', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 153600, 5075241, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (483, N'Redundant', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 198164, 6481753, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (484, N'Nice Guys Finish Last', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 170187, 5604618, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (485, N'Minority', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 168803, 5535061, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (486, N'Warning', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 221910, 7343176, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (487, N'Waiting', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 192757, 6316430, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (488, N'Macy''s Day Parade', 39, 1, 4, N'Billie Joe Armstrong -Words Green Day -Music', 213420, 7075573, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (489, N'Into The Light', 40, 1, 1, N'David Coverdale', 76303, 2452653, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (490, N'River Song', 40, 1, 1, N'David Coverdale', 439510, 14359478, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (491, N'She Give Me ...', 40, 1, 1, N'David Coverdale', 252551, 8385478, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (492, N'Don''t You Cry', 40, 1, 1, N'David Coverdale', 347036, 11269612, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (493, N'Love Is Blind', 40, 1, 1, N'David Coverdale/Earl Slick', 344999, 11409720, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (494, N'Slave', 40, 1, 1, N'David Coverdale/Earl Slick', 291892, 9425200, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (495, N'Cry For Love', 40, 1, 1, N'Bossi/David Coverdale/Earl Slick', 293015, 9567075, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (496, N'Living On Love', 40, 1, 1, N'Bossi/David Coverdale/Earl Slick', 391549, 12785876, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (497, N'Midnight Blue', 40, 1, 1, N'David Coverdale/Earl Slick', 298631, 9750990, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (498, N'Too Many Tears', 40, 1, 1, N'Adrian Vanderberg/David Coverdale', 359497, 11810238, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (499, N'Don''t Lie To Me', 40, 1, 1, N'David Coverdale/Earl Slick', 283585, 9288007, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (500, N'Wherever You May Go', 40, 1, 1, N'David Coverdale', 239699, 7803074, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (501, N'Grito De Alerta', 41, 1, 7, N'Gonzaga Jr.', 202213, 6539422, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (502, N'Não Dá Mais Pra Segurar (Explode Coração)', 41, 1, 7, 219768, 7083012, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (503, N'Começaria Tudo Outra Vez', 41, 1, 7, 196545, 6473395, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (504, N'O Que É O Que É ?', 41, 1, 7, 259291, 8650647, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (505, N'Sangrando', 41, 1, 7, N'Gonzaga Jr/Gonzaguinha', 169717, 5494406, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (506, N'Diga Lá, Coração', 41, 1, 7, 255921, 8280636, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (507, N'Lindo Lago Do Amor', 41, 1, 7, N'Gonzaga Jr.', 249678, 8353191, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (508, N'Eu Apenas Queria Que Voçê Soubesse', 41, 1, 7, 155637, 5130056, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (509, N'Com A Perna No Mundo', 41, 1, 7, N'Gonzaga Jr.', 227448, 7747108, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (510, N'E Vamos À Luta', 41, 1, 7, 222406, 7585112, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (511, N'Um Homem Também Chora (Guerreiro Menino)', 41, 1, 7, 207229, 6854219, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (512, N'Comportamento Geral', 41, 1, 7, N'Gonzaga Jr', 181577, 5997444, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (513, N'Ponto De Interrogação', 41, 1, 7, 180950, 5946265, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (514, N'Espere Por Mim, Morena', 41, 1, 7, N'Gonzaguinha', 207072, 6796523, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (515, N'Meia-Lua Inteira', 23, 1, 7, 222093, 7466288, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (516, N'Voce e Linda', 23, 1, 7, 242938, 8050268, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (517, N'Um Indio', 23, 1, 7, 195944, 6453213, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (518, N'Podres Poderes', 23, 1, 7, 259761, 8622495, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (519, N'Voce Nao Entende Nada - Cotidiano', 23, 1, 7, 421982, 13885612, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (520, N'O Estrangeiro', 23, 1, 7, 374700, 12472890, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (521, N'Menino Do Rio', 23, 1, 7, 147670, 4862277, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (522, N'Qualquer Coisa', 23, 1, 7, 193410, 6372433, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (523, N'Sampa', 23, 1, 7, 185051, 6151831, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (524, N'Queixa', 23, 1, 7, 299676, 9953962, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (525, N'O Leaozinho', 23, 1, 7, 184398, 6098150, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (526, N'Fora Da Ordem', 23, 1, 7, 354011, 11746781, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (527, N'Terra', 23, 1, 7, 401319, 13224055, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (528, N'Alegria, Alegria', 23, 1, 7, 169221, 5497025, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (529, N'Balada Do Louco', 42, 1, 4, N'Arnaldo Baptista - Rita Lee', 241057, 7852328, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (530, N'Ando Meio Desligado', 42, 1, 4, N'Arnaldo Baptista - Rita Lee -  Sérgio Dias', 287817, 9484504, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (531, N'Top Top', 42, 1, 4, N'Os Mutantes - Arnolpho Lima Filho', 146938, 4875374, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (532, N'Baby', 42, 1, 4, N'Caetano Veloso', 177188, 5798202, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (533, N'A E O Z', 42, 1, 4, N'Mutantes', 518556, 16873005, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (534, N'Panis Et Circenses', 42, 1, 4, N'Caetano Veloso - Gilberto Gil', 125152, 4069688, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (535, N'Chão De Estrelas', 42, 1, 4, N'Orestes Barbosa-Sílvio Caldas', 284813, 9433620, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (536, N'Vida De Cachorro', 42, 1, 4, N'Rita Lee - Arnaldo Baptista - Sérgio Baptista', 195186, 6411149, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (537, N'Bat Macumba', 42, 1, 4, N'Gilberto Gil - Caetano Veloso', 187794, 6295223, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (538, N'Desculpe Babe', 42, 1, 4, N'Arnaldo Baptista - Rita Lee', 170422, 5637959, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (539, N'Rita Lee', 42, 1, 4, N'Arnaldo Baptista/Rita Lee/Sérgio Dias', 189257, 6270503, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (540, N'Posso Perder Minha Mulher, Minha Mãe, Desde Que Eu Tenha O Rock And Roll', 42, 1, 4, N'Arnaldo Baptista - Rita Lee - Arnolpho Lima Filho', 222955, 7346254, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (541, N'Banho De Lua', 42, 1, 4, N'B. de Filippi - F. Migliaci - Versão: Fred Jorge', 221831, 7232123, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (542, N'Meu Refrigerador Não Funciona', 42, 1, 4, N'Arnaldo Baptista - Rita Lee - Sérgio Dias', 382981, 12495906, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (543, N'Burn', 43, 1, 1, N'Coverdale/Lord/Paice', 453955, 14775708, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (544, N'Stormbringer', 43, 1, 1, N'Coverdale', 277133, 9050022, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (545, N'Gypsy', 43, 1, 1, N'Coverdale/Hughes/Lord/Paice', 339173, 11046952, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (546, N'Lady Double Dealer', 43, 1, 1, N'Coverdale', 233586, 7608759, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (547, N'Mistreated', 43, 1, 1, N'Coverdale', 758648, 24596235, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (548, N'Smoke On The Water', 43, 1, 1, N'Gillan/Glover/Lord/Paice', 618031, 20103125, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (549, N'You Fool No One', 43, 1, 1, N'Coverdale/Lord/Paice', 804101, 26369966, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (550, N'Custard Pie', 44, 1, 1, N'Jimmy Page/Robert Plant', 253962, 8348257, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (551, N'The Rover', 44, 1, 1, N'Jimmy Page/Robert Plant', 337084, 11011286, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (552, N'In My Time Of Dying', 44, 1, 1, N'John Bonham/John Paul Jones', 666017, 21676727, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (553, N'Houses Of The Holy', 44, 1, 1, N'Jimmy Page/Robert Plant', 242494, 7972503, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (554, N'Trampled Under Foot', 44, 1, 1, N'John Paul Jones', 336692, 11154468, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (555, N'Kashmir', 44, 1, 1, N'John Bonham', 508604, 16686580, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (556, N'Imperatriz', 45, 1, 7, N'Guga/Marquinho Lessa/Tuninho Professor', 339173, 11348710, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (557, N'Beija-Flor', 45, 1, 7, N'Caruso/Cleber/Deo/Osmar', 327000, 10991159, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (558, N'Viradouro', 45, 1, 7, N'Dadinho/Gilbreto Gomes/Gustavo/P.C. Portugal/R. Mocoto', 344320, 11484362, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (559, N'Mocidade', 45, 1, 7, N'Domenil/J. Brito/Joaozinho/Rap, Marcelo Do', 261720, 8817757, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (560, N'Unidos Da Tijuca', 45, 1, 7, N'Douglas/Neves, Vicente Das/Silva, Gilmar L./Toninho Gentil/Wantuir', 338834, 11440689, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (561, N'Salgueiro', 45, 1, 7, N'Augusto/Craig Negoescu/Rocco Filho/Saara, Ze Carlos Da', 305920, 10294741, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (562, N'Mangueira', 45, 1, 7, N'Bizuca/Clóvis Pê/Gilson Bernini/Marelo D''Aguia', 298318, 9999506, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (563, N'União Da Ilha', 45, 1, 7, N'Dito/Djalma Falcao/Ilha, Almir Da/Márcio André', 330945, 11100945, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (564, N'Grande Rio', 45, 1, 7, N'Carlos Santos/Ciro/Claudio Russo/Zé Luiz', 307252, 10251428, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (565, N'Portela', 45, 1, 7, N'Flavio Bororo/Paulo Apparicio/Wagner Alves/Zeca Sereno', 319608, 10712216, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (566, N'Caprichosos', 45, 1, 7, N'Gule/Jorge 101/Lequinho/Luiz Piao', 351320, 11870956, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (567, N'Tradição', 45, 1, 7, N'Adalto Magalha/Lourenco', 269165, 9114880, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (568, N'Império Serrano', 45, 1, 7, N'Arlindo Cruz/Carlos Sena/Elmo Caetano/Mauricao', 334942, 11161196, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (569, N'Tuiuti', 45, 1, 7, N'Claudio Martins/David Lima/Kleber Rodrigues/Livre, Cesare Som', 259657, 8749492, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (570, N'(Da Le) Yaleo', 46, 1, 1, N'Santana', 353488, 11769507, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (571, N'Love Of My Life', 46, 1, 1, N'Carlos Santana & Dave Matthews', 347820, 11634337, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (572, N'Put Your Lights On', 46, 1, 1, N'E. Shrody', 285178, 9394769, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (573, N'Africa Bamba', 46, 1, 1, N'I. Toure, S. Tidiane Toure, Carlos Santana & K. Perazzo', 282827, 9492487, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (574, N'Smooth', 46, 1, 1, N'M. Itaal Shur & Rob Thomas', 298161, 9867455, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (575, N'Do You Like The Way', 46, 1, 1, N'L. Hill', 354899, 11741062, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (576, N'Maria Maria', 46, 1, 1, N'W. Jean, J. Duplessis, Carlos Santana, K. Perazzo & R. Rekow', 262635, 8664601, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (577, N'Migra', 46, 1, 1, N'R. Taha, Carlos Santana & T. Lindsay', 329064, 10963305, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (578, N'Corazon Espinado', 46, 1, 1, N'F. Olivera', 276114, 9206802, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (579, N'Wishing It Was', 46, 1, 1, N'Eale-Eye Cherry, M. Simpson, J. King & M. Nishita', 292832, 9771348, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (580, N'El Farol', 46, 1, 1, N'Carlos Santana & KC Porter', 291160, 9599353, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (581, N'Primavera', 46, 1, 1, N'KC Porter & JB Eckl', 378618, 12504234, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (582, N'The Calling', 46, 1, 1, N'Carlos Santana & C. Thompson', 747755, 24703884, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (583, N'Solução', 47, 1, 7, 247431, 8100449, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (584, N'Manuel', 47, 1, 7, 230269, 7677671, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (585, N'Entre E Ouça', 47, 1, 7, 286302, 9391004, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (586, N'Um Contrato Com Deus', 47, 1, 7, 202501, 6636465, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (587, N'Um Jantar Pra Dois', 47, 1, 7, 244009, 8021589, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (588, N'Vamos Dançar', 47, 1, 7, 226194, 7617432, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (589, N'Um Love', 47, 1, 7, 181603, 6095524, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (590, N'Seis Da Tarde', 47, 1, 7, 238445, 7935898, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (591, N'Baixo Rio', 47, 1, 7, 198008, 6521676, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (592, N'Sombras Do Meu Destino', 47, 1, 7, 280685, 9161539, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (593, N'Do You Have Other Loves?', 47, 1, 7, 295235, 9604273, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (594, N'Agora Que O Dia Acordou', 47, 1, 7, 323213, 10572752, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (595, N'Já!!!', 47, 1, 7, 217782, 7103608, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (596, N'A Rua', 47, 1, 7, 238027, 7930264, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (597, N'Now''s The Time', 48, 1, 2, N'Miles Davis', 197459, 6358868, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (598, N'Jeru', 48, 1, 2, N'Miles Davis', 193410, 6222536, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (599, N'Compulsion', 48, 1, 2, N'Miles Davis', 345025, 11254474, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (600, N'Tempus Fugit', 48, 1, 2, N'Miles Davis', 231784, 7548434, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (601, N'Walkin''', 48, 1, 2, N'Miles Davis', 807392, 26411634, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (602, N'''Round Midnight', 48, 1, 2, N'Miles Davis', 357459, 11590284, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (603, N'Bye Bye Blackbird', 48, 1, 2, N'Miles Davis', 476003, 15549224, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (604, N'New Rhumba', 48, 1, 2, N'Miles Davis', 277968, 9018024, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (605, N'Generique', 48, 1, 2, N'Miles Davis', 168777, 5437017, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (606, N'Summertime', 48, 1, 2, N'Miles Davis', 200437, 6461370, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (607, N'So What', 48, 1, 2, N'Miles Davis', 564009, 18360449, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (608, N'The Pan Piper', 48, 1, 2, N'Miles Davis', 233769, 7593713, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (609, N'Someday My Prince Will Come', 48, 1, 2, N'Miles Davis', 544078, 17890773, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (610, N'My Funny Valentine (Live)', 49, 1, 2, N'Miles Davis', 907520, 29416781, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (611, N'E.S.P.', 49, 1, 2, N'Miles Davis', 330684, 11079866, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (612, N'Nefertiti', 49, 1, 2, N'Miles Davis', 473495, 15478450, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (613, N'Petits Machins (Little Stuff)', 49, 1, 2, N'Miles Davis', 487392, 16131272, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (614, N'Miles Runs The Voodoo Down', 49, 1, 2, N'Miles Davis', 843964, 27967919, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (615, N'Little Church (Live)', 49, 1, 2, N'Miles Davis', 196101, 6273225, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (616, N'Black Satin', 49, 1, 2, N'Miles Davis', 316682, 10529483, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (617, N'Jean Pierre (Live)', 49, 1, 2, N'Miles Davis', 243461, 7955114, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (618, N'Time After Time', 49, 1, 2, N'Miles Davis', 220734, 7292197, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (619, N'Portia', 49, 1, 2, N'Miles Davis', 378775, 12520126, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (620, N'Space Truckin''', 50, 1, 1, N'Blackmore/Gillan/Glover/Lord/Paice', 1196094, 39267613, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (621, N'Going Down / Highway Star', 50, 1, 1, N'Gillan/Glover/Lord/Nix - Blackmore/Paice', 913658, 29846063, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (622, N'Mistreated (Alternate Version)', 50, 1, 1, N'Blackmore/Coverdale', 854700, 27775442, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (623, N'You Fool No One (Alternate Version)', 50, 1, 1, N'Blackmore/Coverdale/Lord/Paice', 763924, 24887209, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (624, N'Jeepers Creepers', 51, 1, 2, 185965, 5991903, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (625, N'Blue Rythm Fantasy', 51, 1, 2, 348212, 11204006, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (626, N'Drum Boogie', 51, 1, 2, 191555, 6185636, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (627, N'Let Me Off Uptown', 51, 1, 2, 187637, 6034685, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (628, N'Leave Us Leap', 51, 1, 2, 182726, 5898810, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (629, N'Opus No.1', 51, 1, 2, 179800, 5846041, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (630, N'Boogie Blues', 51, 1, 2, 204199, 6603153, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (631, N'How High The Moon', 51, 1, 2, 201430, 6529487, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (632, N'Disc Jockey Jump', 51, 1, 2, 193149, 6260820, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (633, N'Up An'' Atom', 51, 1, 2, 179565, 5822645, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (634, N'Bop Boogie', 51, 1, 2, 189596, 6093124, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (635, N'Lemon Drop', 51, 1, 2, 194089, 6287531, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (636, N'Coronation Drop', 51, 1, 2, 176222, 5899898, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (637, N'Overtime', 51, 1, 2, 163030, 5432236, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (638, N'Imagination', 51, 1, 2, 289306, 9444385, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (639, N'Don''t Take Your Love From Me', 51, 1, 2, 282331, 9244238, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (640, N'Midget', 51, 1, 2, 217025, 7257663, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (641, N'I''m Coming Virginia', 51, 1, 2, 280163, 9209827, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (642, N'Payin'' Them Dues Blues', 51, 1, 2, 198556, 6536918, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (643, N'Jungle Drums', 51, 1, 2, 199627, 6546063, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (644, N'Showcase', 51, 1, 2, 201560, 6697510, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (645, N'Swedish Schnapps', 51, 1, 2, 191268, 6359750, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (646, N'Samba Da Bênção', 52, 1, 11, 409965, 13490008, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (647, N'Pot-Pourri N.º 4', 52, 1, 11, 392437, 13125975, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (648, N'Onde Anda Você', 52, 1, 11, 168437, 5550356, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (649, N'Samba Da Volta', 52, 1, 11, 170631, 5676090, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (650, N'Canto De Ossanha', 52, 1, 11, 204956, 6771624, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (651, N'Pot-Pourri N.º 5', 52, 1, 11, 219898, 7117769, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (652, N'Formosa', 52, 1, 11, 137482, 4560873, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (653, N'Como É Duro Trabalhar', 52, 1, 11, 226168, 7541177, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (654, N'Minha Namorada', 52, 1, 11, 244297, 7927967, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (655, N'Por Que Será', 52, 1, 11, 162142, 5371483, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (656, N'Berimbau', 52, 1, 11, 190667, 6335548, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (657, N'Deixa', 52, 1, 11, 179826, 5932799, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (658, N'Pot-Pourri N.º 2', 52, 1, 11, 211748, 6878359, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (659, N'Samba Em Prelúdio', 52, 1, 11, 212636, 6923473, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (660, N'Carta Ao Tom 74', 52, 1, 11, 162560, 5382354, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (661, N'Linha de Passe (João Bosco)', 53, 1, 7, 230948, 7902328, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (662, N'Pela Luz dos Olhos Teus (Miúcha e Tom Jobim)', 53, 1, 7, 163970, 5399626, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (663, N'Chão de Giz (Elba Ramalho)', 53, 1, 7, 274834, 9016916, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (664, N'Marina (Dorival Caymmi)', 53, 1, 7, 172643, 5523628, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (665, N'Aquarela (Toquinho)', 53, 1, 7, 259944, 8480140, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (666, N'Coração do Agreste (Fafá de Belém)', 53, 1, 7, 258194, 8380320, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (667, N'Dona (Roupa Nova)', 53, 1, 7, 243356, 7991295, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (668, N'Começaria Tudo Outra Vez (Maria Creuza)', 53, 1, 7, 206994, 6851151, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (669, N'Caçador de Mim (Sá & Guarabyra)', 53, 1, 7, 238341, 7751360, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (670, N'Romaria (Renato Teixeira)', 53, 1, 7, 244793, 8033885, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (671, N'As Rosas Não Falam (Beth Carvalho)', 53, 1, 7, 116767, 3836641, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (672, N'Wave (Os Cariocas)', 53, 1, 7, 130063, 4298006, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (673, N'Garota de Ipanema (Dick Farney)', 53, 1, 7, 174367, 5767474, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, milliseconds, bytes, unitprice) VALUES (674, N'Preciso Apender a Viver Só (Maysa)', 53, 1, 7, 143464, 4642359, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (675, N'Susie Q', 54, 1, 1, N'Hawkins-Lewis-Broadwater', 275565, 9043825, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (676, N'I Put A Spell On You', 54, 1, 1, N'Jay Hawkins', 272091, 8943000, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (677, N'Proud Mary', 54, 1, 1, N'J. C. Fogerty', 189022, 6229590, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (678, N'Bad Moon Rising', 54, 1, 1, N'J. C. Fogerty', 140146, 4609835, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (679, N'Lodi', 54, 1, 1, N'J. C. Fogerty', 191451, 6260214, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (680, N'Green River', 54, 1, 1, N'J. C. Fogerty', 154279, 5105874, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (681, N'Commotion', 54, 1, 1, N'J. C. Fogerty', 162899, 5354252, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (682, N'Down On The Corner', 54, 1, 1, N'J. C. Fogerty', 164858, 5521804, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (683, N'Fortunate Son', 54, 1, 1, N'J. C. Fogerty', 140329, 4617559, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (684, N'Travelin'' Band', 54, 1, 1, N'J. C. Fogerty', 129358, 4270414, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (685, N'Who''ll Stop The Rain', 54, 1, 1, N'J. C. Fogerty', 149394, 4899579, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (686, N'Up Around The Bend', 54, 1, 1, N'J. C. Fogerty', 162429, 5368701, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (687, N'Run Through The Jungle', 54, 1, 1, N'J. C. Fogerty', 186044, 6156567, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (688, N'Lookin'' Out My Back Door', 54, 1, 1, N'J. C. Fogerty', 152946, 5034670, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (689, N'Long As I Can See The Light', 54, 1, 1, N'J. C. Fogerty', 213237, 6924024, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (690, N'I Heard It Through The Grapevine', 54, 1, 1, N'Whitfield-Strong', 664894, 21947845, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (691, N'Have You Ever Seen The Rain?', 54, 1, 1, N'J. C. Fogerty', 160052, 5263675, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (692, N'Hey Tonight', 54, 1, 1, N'J. C. Fogerty', 162847, 5343807, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (693, N'Sweet Hitch-Hiker', 54, 1, 1, N'J. C. Fogerty', 175490, 5716603, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (694, N'Someday Never Comes', 54, 1, 1, N'J. C. Fogerty', 239360, 7945235, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (695, N'Walking On The Water', 55, 1, 1, N'J.C. Fogerty', 281286, 9302129, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (696, N'Suzie-Q, Pt. 2', 55, 1, 1, N'J.C. Fogerty', 244114, 7986637, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (697, N'Born On The Bayou', 55, 1, 1, N'J.C. Fogerty', 316630, 10361866, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (698, N'Good Golly Miss Molly', 55, 1, 1, N'J.C. Fogerty', 163604, 5348175, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (699, N'Tombstone Shadow', 55, 1, 1, N'J.C. Fogerty', 218880, 7209080, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (700, N'Wrote A Song For Everyone', 55, 1, 1, N'J.C. Fogerty', 296385, 9675875, 0.99);
INSERT INTO track (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) VALUES (701, N'Night Time Is The Right Time', 55, 1, 1, N'J.C. Fogerty', 190119, 6211173, 0.99);

INSERT INTO employee (employeeid, lastname, firstname, title, birthdate, hiredate, address, city, state, country, postalcode,phone, fax,email) VALUES (1, N'Adams', N'Andrew', N'General Manager', '1962/2/18', '2002/8/14', N'11120 Jasper Ave NW', N'Edmonton', N'AB', N'Canada', N'T5K 2N1', N'+1 (780) 428-9482', N'+1 (780) 428-3457', N'andrew@chinookcorp.com');
INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode,phone, fax,email) VALUES (2, N'Edwards', N'Nancy', N'Sales Manager', 1, '1958/12/8', '2002/5/1', N'825 8 Ave SW', N'Calgary', N'AB', N'Canada', N'T2P 2T3', N'+1 (403) 262-3443', N'+1 (403) 262-3322', N'nancy@chinookcorp.com');
INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode,phone, fax,email) VALUES (3, N'Peacock', N'Jane', N'Sales Support Agent', 2, '1973/8/29', '2002/4/1', N'1111 6 Ave SW', N'Calgary', N'AB', N'Canada', N'T2P 5M5', N'+1 (403) 262-3443', N'+1 (403) 262-6712', N'jane@chinookcorp.com');
INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode,phone, fax,email) VALUES (4, N'Park', N'Margaret', N'Sales Support Agent', 2, '1947/9/19', '2003/5/3', N'683 10 Street SW', N'Calgary', N'AB', N'Canada', N'T2P 5G3', N'+1 (403) 263-4423', N'+1 (403) 263-4289', N'margaret@chinookcorp.com');
INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode,phone, fax,email) VALUES (5, N'Johnson', N'Steve', N'Sales Support Agent', 2, '1965/3/3', '2003/10/17', N'7727B 41 Ave', N'Calgary', N'AB', N'Canada', N'T3B 1Y7', N'1 (780) 836-9987', N'1 (780) 836-9543', N'steve@chinookcorp.com');
INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode,phone, fax,email) VALUES (6, N'Mitchell', N'Michael', N'IT Manager', 1, '1973/7/1', '2003/10/17', N'5827 Bowness Road NW', N'Calgary', N'AB', N'Canada', N'T3B 0C5', N'+1 (403) 246-9887', N'+1 (403) 246-9899', N'michael@chinookcorp.com');
INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode,phone, fax,email) VALUES (7, N'King', N'Robert', N'IT Staff', 6, '1970/5/29', '2004/1/2', N'590 Columbia Boulevard West', N'Lethbridge', N'AB', N'Canada', N'T1K 5N8', N'+1 (403) 456-9986', N'+1 (403) 456-8485', N'robert@chinookcorp.com');
INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode,phone, fax,email) VALUES (8, N'Callahan', N'Laura', N'IT Staff', 6, '1968/1/9', '2004/3/4', N'923 7 ST NW', N'Lethbridge', N'AB', N'Canada', N'T1H 1Y8', N'+1 (403) 467-3351', N'+1 (403) 467-8772', N'laura@chinookcorp.com');

INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode,phone, fax,email, supportrepid) VALUES (1, N'Luís', N'Gonçalves', N'Embraer - Empresa Brasileira de Aeronáutica S.A.', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', N'+55 (12) 3923-5555', N'+55 (12) 3923-5566', N'luisg@embraer.com.br', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (2, N'Leonie', N'Köhler', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', N'+49 0711 2842222', N'leonekohler@surfeu.de', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (3, N'François', N'Tremblay', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', N'+1 (514) 721-4711', N'ftremblay@gmail.com', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (4, N'Bjørn', N'Hansen', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', N'+47 22 44 22 22', N'bjorn.hansen@yahoo.no', 4);
INSERT INTO customer (customerid, firstname, lastname, company, address, city, country, postalcode,phone, fax,email, supportrepid) VALUES (5, N'František', N'Wichterlová', N'JetBrains s.r.o.', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', N'+420 2 4172 5555', N'+420 2 4172 5555', N'frantisekw@jetbrains.com', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (6, N'Helena', N'Holý', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', N'+420 2 4177 0449', N'hholy@gmail.com', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (7, N'Astrid', N'Gruber', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', N'+43 01 5134505', N'astrid.gruber@apple.at', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (8, N'Daan', N'Peeters', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', N'+32 02 219 03 03', N'daan_peeters@apple.be', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (9, N'Kara', N'Nielsen', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', N'+453 3331 9991', N'kara.nielsen@jubii.dk', 4);
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode,phone, fax,email, supportrepid) VALUES (10, N'Eduardo', N'Martins', N'Woodstock Discos', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', N'+55 (11) 3033-5446', N'+55 (11) 3033-4564', N'eduardo@woodstock.com.br', 4);
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode,phone, fax,email, supportrepid) VALUES (11, N'Alexandre', N'Rocha', N'Banco do Brasil S.A.', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', N'+55 (11) 3055-3278', N'+55 (11) 3055-8131', N'alero@uol.com.br', 5);
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode,phone, fax,email, supportrepid) VALUES (12, N'Roberto', N'Almeida', N'Riotur', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', N'+55 (21) 2271-7000', N'+55 (21) 2271-7070', N'roberto.almeida@riotur.gov.br', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone, fax,email, supportrepid) VALUES (13, N'Fernanda', N'Ramos', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', N'+55 (61) 3363-5547', N'+55 (61) 3363-7855', N'fernadaramos4@uol.com.br', 4);
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode,phone, fax,email, supportrepid) VALUES (14, N'Mark', N'Philips', N'Telus', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', N'+1 (780) 434-4554', N'+1 (780) 434-5565', N'mphilips12@shaw.ca', 5);
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode,phone, fax,email, supportrepid) VALUES (15, N'Jennifer', N'Peterson', N'Rogers Canada', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', N'+1 (604) 688-2255', N'+1 (604) 688-8756', N'jenniferp@rogers.ca', 3);
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode,phone, fax,email, supportrepid) VALUES (16, N'Frank', N'Harris', N'Google Inc.', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', N'+1 (650) 253-0000', N'+1 (650) 253-0000', N'fharris@google.com', 4);
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode,phone, fax,email, supportrepid) VALUES (17, N'Jack', N'Smith', N'Microsoft Corporation', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', N'+1 (425) 882-8080', N'+1 (425) 882-8081', N'jacksmith@microsoft.com', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone, fax,email, supportrepid) VALUES (18, N'Michelle', N'Brooks', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', N'+1 (212) 221-3546', N'+1 (212) 221-4679', N'michelleb@aol.com', 3);
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode,phone, fax,email, supportrepid) VALUES (19, N'Tim', N'Goyer', N'Apple Inc.', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', N'+1 (408) 996-1010', N'+1 (408) 996-1011', N'tgoyer@apple.com', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (20, N'Dan', N'Miller', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', N'+1 (650) 644-3358', N'dmiller@comcast.com', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (21, N'Kathy', N'Chase', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', N'+1 (775) 223-7665', N'kachase@hotmail.com', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (22, N'Heather', N'Leacock', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', N'+1 (407) 999-7788', N'hleacock@gmail.com', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (23, N'John', N'Gordon', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', N'+1 (617) 522-1333', N'johngordon22@yahoo.com', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (24, N'Frank', N'Ralston', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', N'+1 (312) 332-3232', N'fralston@gmail.com', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (25, N'Victor', N'Stevens', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', N'+1 (608) 257-0597', N'vstevens@yahoo.com', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (26, N'Richard', N'Cunningham', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', N'+1 (817) 924-7272', N'ricunningham@hotmail.com', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (27, N'Patrick', N'Gray', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', N'+1 (520) 622-4200', N'patrick.gray@aol.com', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (28, N'Julia', N'Barnett', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', N'+1 (801) 531-7272', N'jubarnett@gmail.com', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (29, N'Robert', N'Brown', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', N'+1 (416) 363-8888', N'robbrown@shaw.ca', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (30, N'Edward', N'Francis', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', N'+1 (613) 234-3322', N'edfrancis@yachoo.ca', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (31, N'Martha', N'Silk', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', N'+1 (902) 450-0450', N'marthasilk@gmail.com', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (32, N'Aaron', N'Mitchell', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', N'+1 (204) 452-6452', N'aaronmitchell@yahoo.ca', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (33, N'Ellie', N'Sullivan', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', N'+1 (867) 920-2233', N'ellie.sullivan@shaw.ca', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, country,phone,email, supportrepid) VALUES (34, N'João', N'Fernandes', N'Rua da Assunção 53', N'Lisbon', N'Portugal', N'+351 (213) 466-111', N'jfernandes@yahoo.pt', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, country,phone,email, supportrepid) VALUES (35, N'Madalena', N'Sampaio', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', N'+351 (225) 022-448', N'masampaio@sapo.pt', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (36, N'Hannah', N'Schneider', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', N'+49 030 26550280', N'hannah.schneider@yahoo.de', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (37, N'Fynn', N'Zimmermann', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', N'+49 069 40598889', N'fzimmermann@yahoo.de', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (38, N'Niklas', N'Schröder', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', N'+49 030 2141444', N'nschroder@surfeu.de', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (39, N'Camille', N'Bernard', N'4, Rue Milton', N'Paris', N'France', N'75009', N'+33 01 49 70 65 65', N'camille.bernard@yahoo.fr', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (40, N'Dominique', N'Lefebvre', N'8, Rue Hanovre', N'Paris', N'France', N'75002', N'+33 01 47 42 71 71', N'dominiquelefebvre@gmail.com', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (41, N'Marc', N'Dubois', N'11, Place Bellecour', N'Lyon', N'France', N'69002', N'+33 04 78 30 30 30', N'marc.dubois@hotmail.com', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (42, N'Wyatt', N'Girard', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', N'+33 05 56 96 96 96', N'wyatt.girard@yahoo.fr', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (43, N'Isabelle', N'Mercier', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', N'+33 03 80 73 66 99', N'isabelle_mercier@apple.fr', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (44, N'Terhi', N'Hämäläinen', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', N'+358 09 870 2000', N'terhi.hamalainen@apple.fi', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,email, supportrepid) VALUES (45, N'Ladislav', N'Kovács', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', N'ladislav_kovacs@apple.hu', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country,phone,email, supportrepid) VALUES (46, N'Hugh', N'O''Reilly', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', N'+353 01 6792424', N'hughoreilly@apple.ie', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (47, N'Lucas', N'Mancini', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', N'+39 06 39733434', N'lucas.mancini@yahoo.it', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (48, N'Johannes', N'Van der Berg', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', N'+31 020 6223130', N'johavanderberg@yahoo.nl', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (49, N'Stanisław', N'Wójcik', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', N'+48 22 828 37 39', N'stanisław.wójcik@wp.pl', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (50, N'Enrique', N'Muñoz', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', N'+34 914 454 454', N'enrique_munoz@yahoo.es', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (51, N'Joakim', N'Johansson', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', N'+46 08-651 52 52', N'joakim.johansson@yahoo.se', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (52, N'Emma', N'Jones', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', N'+44 020 7707 0707', N'emma_jones@hotmail.com', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (53, N'Phil', N'Hughes', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', N'+44 020 7976 5722', N'phil.hughes@gmail.com', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (54, N'Steve', N'Murray', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', N'+44 0131 315 3300', N'steve.murray@yahoo.uk', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, state, country, postalcode,phone,email, supportrepid) VALUES (55, N'Mark', N'Taylor', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', N'+61 (02) 9332 3633', N'mark.taylor@yahoo.au', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (56, N'Diego', N'Gutiérrez', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', N'+54 (0)11 4311 4333', N'diego.gutierrez@yahoo.ar', 4);
INSERT INTO customer (customerid, firstname, lastname, address, city, country,phone,email, supportrepid) VALUES (57, N'Luis', N'Rojas', N'Calle Lira, 198', N'Santiago', N'Chile', N'+56 (0)2 635 4444', N'luisrojas@yahoo.cl', 5);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (58, N'Manoj', N'Pareek', N'12,Community Centre', N'Delhi', N'India', N'110017', N'+91 0124 39883988', N'manoj.pareek@rediff.com', 3);
INSERT INTO customer (customerid, firstname, lastname, address, city, country, postalcode,phone,email, supportrepid) VALUES (59, N'Puja', N'Srivastava', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', N'+91 080 22289999', N'puja_srivastava@yahoo.in', 3);

INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (1, 2, '2009/1/1', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (2, 4, '2009/1/2', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (3, 8, '2009/1/3', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (4, 14, '2009/1/6', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (5, 23, '2009/1/11', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (6, 37, '2009/1/19', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (7, 38, '2009/2/1', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (8, 40, '2009/2/1', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (9, 42, '2009/2/2', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry,  total) VALUES (10, 46, '2009/2/3', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (11, 52, '2009/2/6', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (12, 2, '2009/2/11', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (13, 16, '2009/2/19', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (14, 17, '2009/3/4', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (15, 19, '2009/3/4', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (16, 21, '2009/3/5', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (17, 25, '2009/3/6', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (18, 31, '2009/3/9', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (19, 40, '2009/3/14', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (20, 54, '2009/3/22', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (21, 55, '2009/4/4', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (22, 57, '2009/4/4', N'Calle Lira, 198', N'Santiago', N'Chile', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (23, 59, '2009/4/5', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (24, 4, '2009/4/6', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (25, 10, '2009/4/9', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (26, 19, '2009/4/14', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (27, 33, '2009/4/22', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (28, 34, '2009/5/5', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (29, 36, '2009/5/5', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (30, 38, '2009/5/6', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (31, 42, '2009/5/7', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (32, 48, '2009/5/10', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (33, 57, '2009/5/15', N'Calle Lira, 198', N'Santiago', N'Chile', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (34, 12, '2009/5/23', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (35, 13, '2009/6/5', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (36, 15, '2009/6/5', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (37, 17, '2009/6/6', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (38, 21, '2009/6/7', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (39, 27, '2009/6/10', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (40, 36, '2009/6/15', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (41, 50, '2009/6/23', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (42, 51, '2009/7/6', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (43, 53, '2009/7/6', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (44, 55, '2009/7/7', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (45, 59, '2009/7/8', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (46, 6, '2009/7/11', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (47, 15, '2009/7/16', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (48, 29, '2009/7/24', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (49, 30, '2009/8/6', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (50, 32, '2009/8/6', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (51, 34, '2009/8/7', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (52, 38, '2009/8/8', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (53, 44, '2009/8/11', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (54, 53, '2009/8/16', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (55, 8, '2009/8/24', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (56, 9, '2009/9/6', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (57, 11, '2009/9/6', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (58, 13, '2009/9/7', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (59, 17, '2009/9/8', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (60, 23, '2009/9/11', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (61, 32, '2009/9/16', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry,  total) VALUES (62, 46, '2009/9/24', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (63, 47, '2009/10/7', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (64, 49, '2009/10/7', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (65, 51, '2009/10/8', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (66, 55, '2009/10/9', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (67, 2, '2009/10/12', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (68, 11, '2009/10/17', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (69, 25, '2009/10/25', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (70, 26, '2009/11/7', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (71, 28, '2009/11/7', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (72, 30, '2009/11/8', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (73, 34, '2009/11/9', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (74, 40, '2009/11/12', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (75, 49, '2009/11/17', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (76, 4, '2009/11/25', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (77, 5, '2009/12/8', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (78, 7, '2009/12/8', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (79, 9, '2009/12/9', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (80, 13, '2009/12/10', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (81, 19, '2009/12/13', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (82, 28, '2009/12/18', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (83, 42, '2009/12/26', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (84, 43, '2010/1/8', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (85, 45, '2010/1/8', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (86, 47, '2010/1/9', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (87, 51, '2010/1/10', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 6.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (88, 57, '2010/1/13', N'Calle Lira, 198', N'Santiago', N'Chile', 17.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (89, 7, '2010/1/18', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 18.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (90, 21, '2010/1/26', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (91, 22, '2010/2/8', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (92, 24, '2010/2/8', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (93, 26, '2010/2/9', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (94, 30, '2010/2/10', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (95, 36, '2010/2/13', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (96, 45, '2010/2/18', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 21.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (97, 59, '2010/2/26', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 1.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (98, 1, '2010/3/11', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 3.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (99, 3, '2010/3/11', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 3.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (100, 5, '2010/3/12', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (101, 9, '2010/3/13', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (102, 15, '2010/3/16', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 9.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (103, 24, '2010/3/21', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 15.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (104, 38, '2010/3/29', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (105, 39, '2010/4/11', N'4, Rue Milton', N'Paris', N'France', N'75009', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (106, 41, '2010/4/11', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (107, 43, '2010/4/12', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (108, 47, '2010/4/13', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (109, 53, '2010/4/16', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (110, 3, '2010/4/21', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (111, 17, '2010/4/29', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (112, 18, '2010/5/12', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (113, 20, '2010/5/12', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (114, 22, '2010/5/13', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (115, 26, '2010/5/14', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (116, 32, '2010/5/17', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (117, 41, '2010/5/22', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (118, 55, '2010/5/30', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (119, 56, '2010/6/12', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (120, 58, '2010/6/12', N'12,Community Centre', N'Delhi', N'India', N'110017', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (121, 1, '2010/6/13', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (122, 5, '2010/6/14', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (123, 11, '2010/6/17', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (124, 20, '2010/6/22', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (125, 34, '2010/6/30', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (126, 35, '2010/7/13', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (127, 37, '2010/7/13', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (128, 39, '2010/7/14', N'4, Rue Milton', N'Paris', N'France', N'75009', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (129, 43, '2010/7/15', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (130, 49, '2010/7/18', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (131, 58, '2010/7/23', N'12,Community Centre', N'Delhi', N'India', N'110017', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (132, 13, '2010/7/31', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (133, 14, '2010/8/13', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (134, 16, '2010/8/13', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (135, 18, '2010/8/14', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (136, 22, '2010/8/15', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (137, 28, '2010/8/18', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (138, 37, '2010/8/23', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (139, 51, '2010/8/31', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (140, 52, '2010/9/13', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (141, 54, '2010/9/13', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (142, 56, '2010/9/14', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (143, 1, '2010/9/15', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (144, 7, '2010/9/18', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (145, 16, '2010/9/23', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (146, 30, '2010/10/1', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (147, 31, '2010/10/14', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (148, 33, '2010/10/14', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (149, 35, '2010/10/15', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (150, 39, '2010/10/16', N'4, Rue Milton', N'Paris', N'France', N'75009', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (151, 45, '2010/10/19', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (152, 54, '2010/10/24', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (153, 9, '2010/11/1', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (154, 10, '2010/11/14', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (155, 12, '2010/11/14', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (156, 14, '2010/11/15', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (157, 18, '2010/11/16', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (158, 24, '2010/11/19', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (159, 33, '2010/11/24', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (160, 47, '2010/12/2', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (161, 48, '2010/12/15', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (162, 50, '2010/12/15', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (163, 52, '2010/12/16', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (164, 56, '2010/12/17', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (165, 3, '2010/12/20', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (166, 12, '2010/12/25', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (167, 26, '2011/1/2', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (168, 27, '2011/1/15', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (169, 29, '2011/1/15', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (170, 31, '2011/1/16', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (171, 35, '2011/1/17', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (172, 41, '2011/1/20', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (173, 50, '2011/1/25', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (174, 5, '2011/2/2', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (175, 6, '2011/2/15', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (176, 8, '2011/2/15', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (177, 10, '2011/2/16', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (178, 14, '2011/2/17', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (179, 20, '2011/2/20', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (180, 29, '2011/2/25', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (181, 43, '2011/3/5', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (182, 44, '2011/3/18', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry,  total) VALUES (183, 46, '2011/3/18', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (184, 48, '2011/3/19', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (185, 52, '2011/3/20', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (186, 58, '2011/3/23', N'12,Community Centre', N'Delhi', N'India', N'110017', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (187, 8, '2011/3/28', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (188, 22, '2011/4/5', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (189, 23, '2011/4/18', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (190, 25, '2011/4/18', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (191, 27, '2011/4/19', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (192, 31, '2011/4/20', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (193, 37, '2011/4/23', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 14.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry,  total) VALUES (194, 46, '2011/4/28', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 21.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (195, 1, '2011/5/6', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (196, 2, '2011/5/19', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (197, 4, '2011/5/19', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (198, 6, '2011/5/20', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (199, 10, '2011/5/21', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (200, 16, '2011/5/24', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (201, 25, '2011/5/29', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 18.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (202, 39, '2011/6/6', N'4, Rue Milton', N'Paris', N'France', N'75009', 1.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (203, 40, '2011/6/19', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 2.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (204, 42, '2011/6/19', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 3.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (205, 44, '2011/6/20', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 7.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (206, 48, '2011/6/21', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 8.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (207, 54, '2011/6/24', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (208, 4, '2011/6/29', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 15.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (209, 18, '2011/7/7', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (210, 19, '2011/7/20', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (211, 21, '2011/7/20', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (212, 23, '2011/7/21', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (213, 27, '2011/7/22', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (214, 33, '2011/7/25', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (215, 42, '2011/7/30', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (216, 56, '2011/8/7', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (217, 57, '2011/8/20', N'Calle Lira, 198', N'Santiago', N'Chile', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (218, 59, '2011/8/20', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (219, 2, '2011/8/21', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (220, 6, '2011/8/22', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (221, 12, '2011/8/25', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (222, 21, '2011/8/30', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (223, 35, '2011/9/7', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (224, 36, '2011/9/20', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (225, 38, '2011/9/20', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (226, 40, '2011/9/21', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (227, 44, '2011/9/22', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (228, 50, '2011/9/25', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (229, 59, '2011/9/30', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (230, 14, '2011/10/8', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (231, 15, '2011/10/21', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (232, 17, '2011/10/21', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (233, 19, '2011/10/22', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (234, 23, '2011/10/23', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (235, 29, '2011/10/26', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (236, 38, '2011/10/31', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (237, 52, '2011/11/8', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (238, 53, '2011/11/21', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (239, 55, '2011/11/21', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (240, 57, '2011/11/22', N'Calle Lira, 198', N'Santiago', N'Chile', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (241, 2, '2011/11/23', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (242, 8, '2011/11/26', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (243, 17, '2011/12/1', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (244, 31, '2011/12/9', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (245, 32, '2011/12/22', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (246, 34, '2011/12/22', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (247, 36, '2011/12/23', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (248, 40, '2011/12/24', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry,  total) VALUES (249, 46, '2011/12/27', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (250, 55, '2012/1/1', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (251, 10, '2012/1/9', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (252, 11, '2012/1/22', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (253, 13, '2012/1/22', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (254, 15, '2012/1/23', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (255, 19, '2012/1/24', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (256, 25, '2012/1/27', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (257, 34, '2012/2/1', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (258, 48, '2012/2/9', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (259, 49, '2012/2/22', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (260, 51, '2012/2/22', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (261, 53, '2012/2/23', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (262, 57, '2012/2/24', N'Calle Lira, 198', N'Santiago', N'Chile', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (263, 4, '2012/2/27', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (264, 13, '2012/3/3', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (265, 27, '2012/3/11', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (266, 28, '2012/3/24', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (267, 30, '2012/3/24', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (268, 32, '2012/3/25', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (269, 36, '2012/3/26', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (270, 42, '2012/3/29', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (271, 51, '2012/4/3', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (272, 6, '2012/4/11', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (273, 7, '2012/4/24', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (274, 9, '2012/4/24', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (275, 11, '2012/4/25', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (276, 15, '2012/4/26', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (277, 21, '2012/4/29', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (278, 30, '2012/5/4', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (279, 44, '2012/5/12', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (280, 45, '2012/5/25', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (281, 47, '2012/5/25', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (282, 49, '2012/5/26', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (283, 53, '2012/5/27', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (284, 59, '2012/5/30', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (285, 9, '2012/6/4', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (286, 23, '2012/6/12', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (287, 24, '2012/6/25', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (288, 26, '2012/6/25', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (289, 28, '2012/6/26', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (290, 32, '2012/6/27', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (291, 38, '2012/6/30', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (292, 47, '2012/7/5', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (293, 2, '2012/7/13', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (294, 3, '2012/7/26', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (295, 5, '2012/7/26', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (296, 7, '2012/7/27', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (297, 11, '2012/7/28', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (298, 17, '2012/7/31', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 10.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (299, 26, '2012/8/5', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 23.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (300, 40, '2012/8/13', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (301, 41, '2012/8/26', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (302, 43, '2012/8/26', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (303, 45, '2012/8/27', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (304, 49, '2012/8/28', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (305, 55, '2012/8/31', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (306, 5, '2012/9/5', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 16.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (307, 19, '2012/9/13', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 1.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (308, 20, '2012/9/26', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', 3.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (309, 22, '2012/9/26', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 3.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (310, 24, '2012/9/27', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 7.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (311, 28, '2012/9/28', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 11.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (312, 34, '2012/10/1', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 10.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (313, 43, '2012/10/6', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 16.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry,  total) VALUES (314, 57, '2012/10/14', N'Calle Lira, 198', N'Santiago', N'Chile', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (315, 58, '2012/10/27', N'12,Community Centre', N'Delhi', N'India', N'110017', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (316, 1, '2012/10/27', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (317, 3, '2012/10/28', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (318, 7, '2012/10/29', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (319, 13, '2012/11/1', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (320, 22, '2012/11/6', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (321, 36, '2012/11/14', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (322, 37, '2012/11/27', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (323, 39, '2012/11/27', N'4, Rue Milton', N'Paris', N'France', N'75009', 1.98);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (324, 41, '2012/11/28', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 3.96);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (325, 45, '2012/11/29', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 5.94);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingcountry, billingpostalcode,  total) VALUES (326, 51, '2012/12/2', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 8.91);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (327, 1, '2012/12/7', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 13.86);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (328, 15, '2012/12/15', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 0.99);
INSERT INTO invoice (invoiceid, customerid, invoicedate, billingaddress,  billingcity,  billingstate,  billingcountry, billingpostalcode,  total) VALUES (329, 16, '2012/12/28', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 1.98);

INSERT INTO invoiceline (invoicelineid, invoiceid, trackid, unitprice, quantity) VALUES (1, 1, 2, 0.99, 1), (2, 1, 4, 0.99, 1), (3, 2, 6, 0.99, 1), (4, 2, 8, 0.99, 1), (5, 2, 10, 0.99, 1), (6, 2, 12, 0.99, 1), (7, 3, 16, 0.99, 1), (8, 3, 20, 0.99, 1), (9, 3, 24, 0.99, 1), (10, 3, 28, 0.99, 1), (11, 3, 32, 0.99, 1), (12, 3, 36, 0.99, 1), (13, 4, 42, 0.99, 1), (14, 4, 48, 0.99, 1), (15, 4, 54, 0.99, 1), (16, 4, 60, 0.99, 1), (17, 4, 66, 0.99, 1), (18, 4, 72, 0.99, 1), (19, 4, 78, 0.99, 1),
 (20, 4, 84, 0.99, 1), (21, 4, 90, 0.99, 1), (22, 5, 99, 0.99, 1), (23, 5, 108, 0.99, 1), 
 (24, 5, 117, 0.99, 1), (25, 5, 126, 0.99, 1), (26, 5, 135, 0.99, 1), (27, 5, 144, 0.99, 1), (28, 5, 153, 0.99, 1),
 (29, 5, 162, 0.99, 1), (30, 5, 171, 0.99, 1), (31, 5, 180, 0.99, 1), (32, 5, 189, 0.99, 1), (33, 5, 198, 0.99, 1), 
 (34, 5, 207, 0.99, 1), (35, 5, 216, 0.99, 1), (36, 6, 230, 0.99, 1), (37, 7, 231, 0.99, 1), (38, 7, 232, 0.99, 1), 
 (39, 8, 234, 0.99, 1), (40, 8, 236, 0.99, 1), (41, 9, 238, 0.99, 1), (42, 9, 240, 0.99, 1), (43, 9, 242, 0.99, 1), 
 (44, 9, 244, 0.99, 1), (45, 10, 248, 0.99, 1), (46, 10, 252, 0.99, 1), (47, 10, 256, 0.99, 1), (48, 10, 260, 0.99, 1), 
 (49, 10, 264, 0.99, 1), (50, 10, 268, 0.99, 1), (51, 11, 274, 0.99, 1), (52, 11, 280, 0.99, 1), (53, 11, 286, 0.99, 1),
 
 (54, 11, 292, 0.99, 1), (55, 11, 298, 0.99, 1), (56, 11, 304, 0.99, 1), (57, 11, 310, 0.99, 1), (58, 11, 316, 0.99, 1),
 (59, 11, 322, 0.99, 1), (60, 12, 331, 0.99, 1), (61, 12, 340, 0.99, 1), (62, 12, 349, 0.99, 1), (63, 12, 358, 0.99, 1),
 (64, 12, 367, 0.99, 1), (65, 12, 376, 0.99, 1), (66, 12, 385, 0.99, 1), (67, 12, 394, 0.99, 1), (68, 12, 403, 0.99, 1),
 (69, 12, 412, 0.99, 1), (70, 12, 421, 0.99, 1), (71, 12, 430, 0.99, 1), (72, 12, 439, 0.99, 1), (73, 12, 448, 0.99, 1), 
 (74, 13, 462, 0.99, 1), (75, 14, 463, 0.99, 1), (76, 14, 464, 0.99, 1), (77, 15, 466, 0.99, 1), (78, 15, 468, 0.99, 1), 
 (79, 16, 470, 0.99, 1), (80, 16, 472, 0.99, 1), (81, 16, 474, 0.99, 1), (82, 16, 476, 0.99, 1), (83, 17, 480, 0.99, 1), 
 
 
 
 (84, 17, 484, 0.99, 1), (85, 17, 488, 0.99, 1), (86, 17, 492, 0.99, 1), (87, 17, 496, 0.99, 1), (88, 17, 500, 0.99, 1),
 (89, 18, 506, 0.99, 1), (90, 18, 512, 0.99, 1), (91, 18, 518, 0.99, 1), (92, 18, 524, 0.99, 1), (93, 18, 530, 0.99, 1), 
 (94, 18, 536, 0.99, 1), (95, 18, 542, 0.99, 1), (96, 18, 548, 0.99, 1), (97, 18, 554, 0.99, 1), (98, 19, 563, 0.99, 1), 
 (99, 19, 572, 0.99, 1), (100, 19, 581, 0.99, 1), (101, 19, 590, 0.99, 1), (102, 19, 599, 0.99, 1), (103, 19, 608, 0.99, 1),
 (104, 19, 617, 0.99, 1), (105, 19, 626, 0.99, 1), (106, 19, 635, 0.99, 1), (107, 19, 644, 0.99, 1), (108, 19, 653, 0.99, 1), 
 (109, 19, 662, 0.99, 1), (110, 19, 671, 0.99, 1), (111, 19, 680, 0.99, 1), (112, 20, 694, 0.99, 1), (113, 21, 695, 0.99, 1);

INSERT INTO playlist (playlistid, name) VALUES (2, N'Movies'), (3, N'TV Shows'), (4, N'Audiobooks'), (5, N'90’s Music'), (6, N'Audiobooks'), (7, N'Movies'), (8, N'Music'), (9, N'Music Videos'), (10, N'TV Shows'), (11, N'Brazilian Music'), (12, N'Classical'), (13, N'Classical 101 - Deep Cuts'), (14, N'Classical 101 - Next Steps'), (15, N'Classical 101 - The Basics'), (16, N'Grunge'), (17, N'Heavy Metal Classic'), (18, N'On-The-Go 1');
INSERT INTO playlist (playlistid, name) VALUES (1, N'Music');
INSERT INTO playlisttrack (playlistid, trackid) VALUES  
 (1, 99), (1, 100), (1, 101), (1, 102), (1, 103), (1, 104), (1, 105), (1, 106), (1, 107), (1, 108), (1, 109), (1, 110), (1, 166), 
 (1, 167), (1, 168), (1, 169), (1, 170), (1, 171), (1, 172), (1, 173), (1, 174), (1, 175), (1, 176), (1, 177), (1, 178), (1, 179), 
 (1, 180), (1, 181), (1, 182), (1, 472), (1, 473), (1, 474), (1, 475), (1, 529),
 (1, 530), (1, 531), (1, 532), (1, 533), (1, 534), (1, 535), (1, 536), (1, 537), (1, 538), (1, 539), (1, 540), (1, 541), (1, 542) ;
