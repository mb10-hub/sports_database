USE barragan_cs355sp20;


CREATE TABLE Teams (
team_name varchar(30),
coach varchar(30),
city varchar(30),
stadium varchar(30),
UNIQUE(team_name, stadium),
PRIMARY KEY (team_name) );

CREATE TABLE Players (
id int AUTO_INCREMENT,
player_name varchar(50),
DOB date,
year_started int,
position varchar(15),
foot char(2),
team_name varchar(30),
PRIMARY KEY (id),
FOREIGN KEY (team_name) REFERENCES Teams(team_name)
        ON DELETE SET NULL );

CREATE TABLE Refs (
id int,
name varchar(30),
DOB date,
UNIQUE (id),
PRIMARY KEY (id) );

CREATE TABLE Game_stats (
game_id int,
PRIMARY KEY (game_id) );

CREATE TABLE Game (
game_id int,
playedOn date,
winner varchar(30),
UNIQUE (playedOn),
PRIMARY KEY (game_id, playedOn),
FOREIGN KEY (game_id) REFERENCES Game_stats(game_id)
        ON DELETE CASCADE,
FOREIGN KEY (winner) REFERENCES Teams(team_name)
        ON DELETE SET NULL );

CREATE TABLE Scored (
goal_id int AUTO_INCREMENT,
game_id int,
scoredBy int,
PRIMARY KEY (goal_id, game_id),
FOREIGN KEY (game_id) REFERENCES Game_stats(game_id)
        ON DELETE CASCADE,
FOREIGN KEY (scoredBy) REFERENCES Players(id)
        ON DELETE SET NULL );

CREATE TABLE Play (
team_name varchar(30),
playedOn date,
isHome boolean,
game_id int,
PRIMARY KEY (team_name, playedOn, game_id),
FOREIGN KEY (team_name) REFERENCES Teams(team_name)
        ON DELETE CASCADE,
FOREIGN KEY (playedOn) REFERENCES Game(playedOn)
        ON DELETE CASCADE,
FOREIGN KEY (game_id) REFERENCES Game_stats(game_id)
        ON DELETE CASCADE );

CREATE TABLE Plays (
player_id int,
game_id int,
PRIMARY KEY (player_id, game_id),
FOREIGN KEY (player_id) REFERENCES Players(id)
        ON DELETE CASCADE,
FOREIGN KEY (game_id) REFERENCES Game_stats(game_id)
        ON DELETE CASCADE );

CREATE TABLE Reffing (
game_id int,
ref_id int,
playedOn date,
PRIMARY KEY (ref_id, game_id, playedOn),
FOREIGN KEY (ref_id) REFERENCES Refs(id)
        ON DELETE CASCADE,
FOREIGN KEY (game_id) REFERENCES Game_stats(game_id)
        ON DELETE CASCADE,
FOREIGN KEY (playedOn) REFERENCES Game(playedOn)
        ON DELETE CASCADE );


-- populate                                                                                                                                                                          
INSERT INTO Teams (team_name, coach, city, stadium) VALUE
       ('LA Galaxy', 'Guillermo Barros Schelotto', 'Los Angeles', 'Mercedes-Benz-Stadium'),
       ('FCLA', 'Bob Bradley', 'Los Angeles', 'Banc of California'),
       ('New York Red Bulls', 'Chris Armas', 'New York', 'Red Bull Arena'),
       ('San Jose Earthquakes', 'Matias Almeyda', 'San Jose', 'Earthquakes Stadium'),
       ('Seattle Sounders', 'Brian Schmetzer', 'Seattle', 'CenturyLink Field');

INSERT INTO Players(player_name, DOB, year_started, position, foot, team_name) VALUE
       ('David Bingham', '2002-10-22', 2020, 'Forward', 'RT', 'LA Galaxy'),
       ('Efrain Alvarez', '2002-06-19', 2018, 'Midfielder', 'RT', 'LA Galaxy'),
       ('Jonathan dos Santos', '1990-04-26', 2017, 'Midfielder', 'LT', 'LA Galaxy'),
       ('Javier Hernandez', '1988-06-01', 2020, 'Forward', 'RT', 'LA Galaxy'),
       ('David Bingham', '1989-10-19', 2011, 'Goalkeeper', 'RT', 'LA Galaxy'),
       ('Latif Blessing', '1996-12-30', 2017, 'Midfielder', 'RT','FCLA'),
       ('Brian Rodríguez', '2000-05-20', 2019, 'Forward', 'RT', 'FCLA'),
       ('Diego Rossi', '1998-03-05', 2018, 'Forward', 'RT', 'FCLA'),
       ('Pablo Sisniega', '1995-07-07', 2019, 'Goalkeeper', 'RT', 'FCLA'),
       ('Carlos Vela', '1989-03-01', 2018, 'Forward', 'LT', 'FCLA'),
       ('Tom Barlow', '1995-07-08', 2019, 'Forward', 'RT', 'New York Red Bulls'),
       ('David Jensen', '1992-03-25', 2020, 'Goalkeeper', 'RT', 'New York Red Bulls'),
       ('Chris Lema', '1996-08-05', 2020, 'Midfeilder', 'LT', 'New York Red Bulls'),
       ('Ben Mines', '2000-05-13', 2018, 'Midfeilder', 'RT', 'New York Red Bulls'),
       ('Kaku', '1995-01-11', 2018, 'Midfeilder', 'RT', 'New York Red Bulls'),
       ('Eric Calvillo', '1998-01-02', 2020,  'Midfeilder', 'RT', 'San Jose Earthquakes'),
       ('Magnus Eriksson', '1990-08-04', 2018, 'Midfielder', 'RT', 'San Jose Earthquakes'),
       ('Marcos Lopez', '1999-11-02', 2019, 'Defender', 'RT', 'San Jose Earthquakes'),
       ('Chris Wondolowski', '1983-01-28', 2003, 'Forward', 'RT', 'San Jose Earthquakes'),
       ('Matt Bersano', '1992-10-09', 2017, 'Goalkeeper', 'RT', 'San Jose Earthquakes'),
       ('Jordan Morris', '1994-10-26', 2016, 'Forward', 'RT', 'Seattle Sounders'),
       ('Raúl Ruidíaz', '1990-07-25', 2018, 'Forward', 'RT', 'Seattle Sounders'),
       ('Cristian Roldan', '1995-06-03', 2015, 'Midfeilder', 'RT', 'Seattle Sounders'),
       ('Trey Muse', '1999-07-26', 2019, 'Goalkeeper', 'RT', 'Seattle Sounders'),
       ('Handwalla Bwana', '1997-06-25', 2018, 'Midfeilder', 'LT', 'Seattle Sounders');

INSERT INTO Game_stats(game_id) VALUE
       (01),
       (02),
       (03),
       (04);

INSERT INTO Game (game_id, playedOn, winner) VALUE
       (01, '2019-01-05', 'FCLA'),
       (02, '2019-02-05', 'San Jose Earthquakes'),
       (03, '2019-03-05', 'LA Galaxy'),
       (04, '2019-04-05', 'FCLA');


INSERT INTO Refs(id, name, DOB) VALUE
       (000, 'Jair Marrufo', '1993-12-04'),
       (001, 'Chris Penso', '1991-11-04'),
       (002, 'Allen Chapman', '1992-01-05'),
       (003, 'Armando Villarreal', '1995-06-04'),
       (004, 'Ismail Elfath', '1995-09-07'),
       (005, 'Robert Sibiga', '1997-01-06');

INSERT INTO Scored(game_id, scoredBy) VALUE
       (01, 10),
       (01, 10),
       (01, 10),
       (01, 4),
       (01, 4),
       (02, 13),
       (02, 19),
       (02, 19),
       (03, 4),
       (04, 10);

INSERT INTO Play (playedOn, team_name, isHome, game_id) VALUES
       ('2019-01-05', 'LA Galaxy', 1, 01),
       ('2019-01-05', 'FCLA', 0, 01),
       ('2019-02-05', 'New York Red Bulls', 0, 02),
       ('2019-02-05', 'San Jose Earthquakes', 1, 02),
       ('2019-03-05', 'Seattle Sounders', 1, 03),
       ('2019-03-05', 'LA Galaxy', 0, 03),
       ('2019-04-05', 'FCLA', 1, 04),
       ('2019-04-05', 'New York Red Bulls', 0, 04);


INSERT INTO Plays (player_id, game_id) VALUES
       (1, 01),
       (2, 01),
       (3, 01),
       (4, 01),
       (5, 01),
       (6, 01),
       (7, 01),
       (8, 01),
       (9, 01),
       (10, 01),
       (11, 02),
       (12, 02),
       (13, 02),
       (14, 02),
       (15, 02),
       (16, 02),
       (17, 02),
       (18, 02),
       (19, 02),
       (20, 02),
       (21, 03),
       (22, 03),
       (23, 03),
       (24, 03),
       (25, 03),
       (1, 03),
       (2, 03),
       (3, 03),
       (4, 03),
       (5, 03),
       (6, 04),
       (7, 04),
       (8, 04),
       (9, 04),
       (10, 04),
       (11, 04),
       (12, 04),
       (13, 04),
       (14, 04),
       (15, 04);


INSERT INTO Reffing (game_id, ref_id) VALUES
       (01, 000, '2019-01-05'),
       (01, 001, '2019-01-05'),
       (01, 002, '2019-01-05'),
       (01, 003, '2019-01-05'),
       (02, 001, '2019-02-05'),
       (02, 004, '2019-02-05'),
       (02, 005, '2019-02-05'),
       (02, 002, '2019-02-05'),
       (03, 002, '2019-03-05'),
       (03, 003, '2019-03-05'),
       (03, 004, '2019-03-05'),
       (03, 005, '2019-03-05'),
       (04, 003, '2019-04-05'),
       (04, 004, '2019-04-05'),
       (04, 005, '2019-04-05'),
       (04, 001, '2019-04-05');
