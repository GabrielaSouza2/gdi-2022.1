  -- ESQUEMA FÍSICO: COPA DO MUNDO - GDI 22.1


-----------------------------
-- CRIAÇÃO DO BD --
-----------------------------


CREATE TABLE ESTADIO(

NOME VARCHAR(80) CONSTRAINT NN_ESTADIO_NOME NOT NULL,
ID_ESTADIO NUMBER(10) NOT NULL,
LOCALIZACAO_RUA VARCHAR(80),
LOCALIZACAO_BAIRRO VARCHAR(80),
LOCALIZACAO_CIDADE VARCHAR(80),
LOCALIZACAO_CEP VARCHAR(80),

CONSTRAINT PK_ID_ESTADIO PRIMARY KEY (ID_ESTADIO));

-- 

CREATE TABLE COPA_DO_MUNDO(
ANO NUMBER(4),
PAIS_SEDE VARCHAR(80),
CONSTRAINT PK_PAIS_COPA PRIMARY KEY (ANO)
);

--

CREATE TABLE MASCOTE(
NOME VARCHAR(80),
CONSTRAINT PK_NOME_MASCOTE PRIMARY KEY (NOME)

);

--

CREATE TABLE RANKING(
ID NUMBER(4),
POSICAO VARCHAR (20),
CONSTRAINT ID PRIMARY KEY(ID)
);

-- 

CREATE TABLE SELECAO(
PAIS VARCHAR(80),
NOME_DO_TECNICO VARCHAR(80) NOT NULL,
CONSTRAINT PK_PAIS_SELECAO PRIMARY KEY(PAIS)
);

--

CREATE TABLE ALCUNHA(
PAIS VARCHAR(80),
ALCUNHA VARCHAR(50) NOT NULL,
CONSTRAINT FK_PAIS FOREIGN KEY (PAIS) REFERENCES SELECAO(PAIS),
CONSTRAINT PK_PAIS_ALCUNHA PRIMARY KEY (PAIS, ALCUNHA)
);

--

CREATE TABLE JOGADOR ( 

PAIS VARCHAR(80), 
N_CAMISA NUMBER(4),
POSICAO VARCHAR(80),
IDADE NUMBER(3),
NOME VARCHAR(80),
CAPITAO_PAIS VARCHAR(80),
CAPITAO_N_CAMISA NUMBER(3),
CONSTRAINT PK_JOGADOR PRIMARY KEY (PAIS, N_CAMISA),
CONSTRAINT FK_CAPITAO FOREIGN KEY (CAPITAO_PAIS,CAPITAO_N_CAMISA) REFERENCES JOGADOR(PAIS, N_CAMISA)

);

--

CREATE TABLE PARTIDA ( 
COD_PARTIDA NUMBER(6),
PAIS_VISITANTE VARCHAR(80) NOT NULL UNIQUE,
PAIS_MANDANTE VARCHAR(80) NOT NULL UNIQUE,
CONSTRAINT PK_COD_PARTIDA PRIMARY KEY (COD_PARTIDA),
CONSTRAINT FK_PAIS_VISITANTE FOREIGN KEY (PAIS_VISITANTE) REFERENCES SELECAO (PAIS),
CONSTRAINT FK_PAIS_MANDANTE FOREIGN KEY (PAIS_MANDANTE) REFERENCES SELECAO (PAIS)
);

 --

CREATE TABLE ARBITRO ( 
ID_ARBITRO NUMBER(6),
NOME VARCHAR(80),
NACIONALIDADE VARCHAR(50),
CONSTRAINT PK_ARBITRO PRIMARY KEY (ID_ARBITRO)

);

 --

CREATE TABLE ARBITRO_PRINCIPAL( 
ID_ARBITRO_PRINCIPAL NUMBER(6),
CONSTRAINT PK_ARBITRO_PRINCIPAL PRIMARY KEY (ID_ARBITRO_PRINCIPAL),
CONSTRAINT FK_ARBITRO_PRINCIPAL FOREIGN KEY (ID_ARBITRO_PRINCIPAL) REFERENCES ARBITRO (ID_ARBITRO)
);

  --

CREATE TABLE COMANDA(
COD_PARTIDA NUMBER(6),
ID_ARBITRO_PRINCIPAL NUMBER(6),
CONSTRAINT FK_COMANDA_PARTIDA FOREIGN KEY (COD_PARTIDA) REFERENCES PARTIDA(COD_PARTIDA),
CONSTRAINT FK_COMANDA_ARBITRO FOREIGN KEY (ID_ARBITRO_PRINCIPAL) REFERENCES ARBITRO_PRINCIPAL(ID_ARBITRO_PRINCIPAL),
CONSTRAINT PK_COMANDA PRIMARY KEY (COD_PARTIDA, ID_ARBITRO_PRINCIPAL)
);

CREATE TABLE SEDIA( 
ID_ESTADIO NUMBER(6),
ANO NUMBER(6),
CONSTRAINT FK_SEDIA_ESTADIO FOREIGN KEY (ID_ESTADIO) REFERENCES ESTADIO(ID_ESTADIO),
CONSTRAINT FK_SEDIA_ANO FOREIGN KEY (ANO) REFERENCES COPA_DO_MUNDO(ANO),
CONSTRAINT PK_SEDIA PRIMARY KEY (ID_ESTADIO,ANO)
);

--

CREATE TABLE MASCOTE_COPA(
ANO NUMBER(6),
NOME VARCHAR(80) NOT NULL UNIQUE,
PAIS_SEDE VARCHAR(80),
CONSTRAINT PK_MASCOTE_COPA PRIMARY KEY(ANO),
CONSTRAINT AK_MASCOTE_COPA UNIQUE (NOME, PAIS_SEDE)
);

--

CREATE TABLE TEM(
ANO NUMBER(6),
PAIS VARCHAR(80),
ID_RANKING NUMBER(6) NOT NULL,
CONSTRAINT FK_TEM_ANO FOREIGN KEY (ANO) REFERENCES COPA_DO_MUNDO(ANO),
CONSTRAINT FK_TEM_PAIS FOREIGN KEY (PAIS) REFERENCES SELECAO(PAIS),
CONSTRAINT PK_TEM PRIMARY KEY(ANO, PAIS)
);

--

CREATE TABLE POSSUI(
ANO NUMBER(6),
ID_ARBITRO_PRINCIPAL NUMBER(6),
CONSTRAINT FK_POSSUI_ANO FOREIGN KEY (ANO) REFERENCES COPA_DO_MUNDO(ANO),
CONSTRAINT FK_POSSUI_ID_ARBITRO_PRINCIPAL FOREIGN KEY (ID_ARBITRO_PRINCIPAL) REFERENCES ARBITRO_PRINCIPAL(ID_ARBITRO_PRINCIPAL),
CONSTRAINT PK_POSSUI PRIMARY KEY(ANO, ID_ARBITRO_PRINCIPAL)
);

--
CREATE TABLE PUNICAO(
COD_PARTIDA NUMBER(6),
ID_ARBITRO_PRINCIPAL NUMBER(6),
PAIS VARCHAR(80),
N_CAMISA NUMBER(6),
COR_DO_CARTAO VARCHAR(20),
CONSTRAINT FK_PUNICAO_COMANDA FOREIGN KEY (COD_PARTIDA, ID_ARBITRO_PRINCIPAL) REFERENCES COMANDA(COD_PARTIDA, ID_ARBITRO_PRINCIPAL),
CONSTRAINT FK_PUNICAO_JOGADOR FOREIGN KEY (PAIS, N_CAMISA) REFERENCES JOGADOR(PAIS, N_CAMISA),
CONSTRAINT PK_PUNICAO PRIMARY KEY (COD_PARTIDA,ID_ARBITRO_PRINCIPAL,PAIS,N_CAMISA)
);

-----------------------------------------
-- POVOAMENTO DO BD --
-----------------------------------------


------------------------------
-- POVOAMENTO ESTADIO --
------------------------------

insert into ESTADIO (NOME, ID_ESTADIO , LOCALIZACAO_RUA, LOCALIZACAO_BAIRRO, LOCALIZACAO_CIDADE, LOCALIZACAO_CEP) 
values ('Arena Rostov', 89, 'Brown', 'Rostov do Don', 'Rostov', '36177');
insert into ESTADIO (NOME, ID_ESTADIO , LOCALIZACAO_RUA, LOCALIZACAO_BAIRRO, LOCALIZACAO_CIDADE, LOCALIZACAO_CEP) 
values ('Kaliningrado Stadium', 11, 'Northport', 'Silver Spring', 'Kaliningrado', '20904');
insert into ESTADIO (NOME, ID_ESTADIO , LOCALIZACAO_RUA, LOCALIZACAO_BAIRRO, LOCALIZACAO_CIDADE, LOCALIZACAO_CEP) 
values ('Big Swan Stadium', 40, 'Aberg', 'Albirex', 'Niigata', '31914');
insert into ESTADIO (NOME, ID_ESTADIO , LOCALIZACAO_RUA, LOCALIZACAO_BAIRRO, LOCALIZACAO_CIDADE, LOCALIZACAO_CEP) 
values ('Sapporo Dome', 32, 'Lindbergh', 'Nippon', 'Hakkaido', '30905');
insert into ESTADIO (NOME, ID_ESTADIO , LOCALIZACAO_RUA, LOCALIZACAO_BAIRRO, LOCALIZACAO_CIDADE, LOCALIZACAO_CEP) 
values ('Arena Penambuco', 42, 'Deus e Fiel', 'Penedo', 'Sao Lourenço da Mata', '27605');
insert into ESTADIO (NOME, ID_ESTADIO , LOCALIZACAO_RUA, LOCALIZACAO_BAIRRO, LOCALIZACAO_CIDADE, LOCALIZACAO_CEP) 
values ('Arena das Dunas', 13, 'Prudente de Morais', 'Lagoa Nova', 'Natal', '25709');
insert into ESTADIO (NOME, ID_ESTADIO , LOCALIZACAO_RUA, LOCALIZACAO_BAIRRO, LOCALIZACAO_CIDADE, LOCALIZACAO_CEP) 
values ('Princess Magogo Stadium', 81, 'North', 'KwaMashu', 'Durban', '85305');
insert into ESTADIO (NOME, ID_ESTADIO , LOCALIZACAO_RUA, LOCALIZACAO_BAIRRO, LOCALIZACAO_CIDADE, LOCALIZACAO_CEP) 
values ('Nelson Mandela Bay Stadium', 77, 'Lillian', 'North End', 'Gqeberha', '94291');
insert into ESTADIO (NOME, ID_ESTADIO , LOCALIZACAO_RUA, LOCALIZACAO_BAIRRO, LOCALIZACAO_CIDADE, LOCALIZACAO_CEP) 
values ('Foxboro Stadium', 7, 'Northview', 'Foxborough', 'Massachusetts', '10310');
insert into ESTADIO (NOME, ID_ESTADIO , LOCALIZACAO_RUA, LOCALIZACAO_BAIRRO, LOCALIZACAO_CIDADE, LOCALIZACAO_CEP) 
values ('Azteca Stadium', 34, 'Everett', 'Coyoacan', 'Ciudad de Mexico', '32215');


-----------------------------------------------------
-- POVOAMENTO COPA_DO_MUNDO --
-----------------------------------------------------

insert into COPA_DO_MUNDO(ANO, PAIS_SEDE) values (1994, 'United States');
insert into COPA_DO_MUNDO(ANO, PAIS_SEDE) values (1986, 'Mexico');
insert into COPA_DO_MUNDO(ANO, PAIS_SEDE) values (2002, 'Japan');
insert into COPA_DO_MUNDO(ANO, PAIS_SEDE) values (2018, 'Russia');
insert into COPA_DO_MUNDO(ANO, PAIS_SEDE) values (2010, 'South Africa');
insert into COPA_DO_MUNDO(ANO, PAIS_SEDE) values (2014, 'Brazil');


-----------------------------------------------------
-- POVOAMENTO MASCOTE --
-----------------------------------------------------

insert into MASCOTE (NOME) values ('Striker');
insert into MASCOTE (NOME) values ('Zabivaka');
insert into MASCOTE (NOME) values ('Pique');
insert into MASCOTE (NOME) values ('Fuleco');
insert into MASCOTE (NOME) values ('Zakumi');
insert into MASCOTE (NOME) values ('Spheriks');


-----------------------------------------------------
-- POVOAMENTO RANKING --
-----------------------------------------------------

insert into RANKING (ID, POSICAO) values (17, 26);
insert into RANKING (ID, POSICAO) values (11, 24);
insert into RANKING (ID, POSICAO) values (6, 21);
insert into RANKING (ID, POSICAO) values (82, 2);
insert into RANKING (ID, POSICAO) values (3, 29);
insert into RANKING (ID, POSICAO) values (77, 16);
insert into RANKING (ID, POSICAO) values (16, 17);
insert into RANKING (ID, POSICAO) values (45, 6);
insert into RANKING (ID, POSICAO) values (43, 29);
insert into RANKING (ID, POSICAO) values (91, 14);
insert into RANKING (ID, POSICAO) values (18, 13);
insert into RANKING (ID, POSICAO) values (72, 27);
insert into RANKING (ID, POSICAO) values (16, 18);


-----------------------------------------------------
-- POVOAMENTO SELEÇÃO --
-----------------------------------------------------

insert into SELECAO (PAIS, NOME_DO_TECNICO) values ('Brazil', 'Marcus');
insert into SELECAO (PAIS, NOME_DO_TECNICO) values ('Russia', 'Niven');
insert into SELECAO (PAIS, NOME_DO_TECNICO) values ('United States', 'Abner');
insert into SELECAO (PAIS, NOME_DO_TECNICO) values ('Japan', 'Inness');
insert into SELECAO (PAIS, NOME_DO_TECNICO) values ('Mexico', 'Willem');
insert into SELECAO (PAIS, NOME_DO_TECNICO) values ('South Africa', 'North');


-----------------------------------------------------
-- POVOAMENTO ALCUNHA --
-----------------------------------------------------

insert into ALCUNHA (PAIS, ALCUNHA) values ('Russia', 'Geordie');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Russia', 'Ezekiel');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Brazil', 'Gerald');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Brazil', 'Odo');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Russia', 'Abel');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Brazil', 'Quentin');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Russia', 'Nye');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Russia', 'Gery');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Brazil', 'Tucky');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Russia', 'Brade');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Brazil', 'Tanner');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Brazil', 'Cecilio');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Brazil', 'Kurt');
insert into ALCUNHA (PAIS, ALCUNHA) values ('Russia', 'Saw');
insert into ALCUNHA (PAIS, ALCUNHA) values ('United States', 'Walker');


-----------------------------------------------------
-- POVOAMENTO JOGADOR --
-----------------------------------------------------

insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('United States', 50, 'atacante', 26, 'Galvan');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('South Africa', 75, 'centro-avante', 21, 'Tann');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('United States', 17, 'lateral direito', 34, 'Adelbert');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('South Africa', 34, 'meio campo', 26, 'Chase');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('Russia', 60, 'zagueiro', 27, 'Otes');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('Russia', 49, 'goleiro', 24, 'Hughie');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('Japan', 96, 'lateral esquerdo', 22, 'Seward');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('United States', 29, 'atacante', 27, 'Anselm');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('United States', 170, 'goleiro', 39, 'Al');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('Russia', 94, 'atacante', 24, 'Godwin');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('Mexico', 61, 'zagueiro', 17, 'Gregorio');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('Japan', 89, 'lateral esquerdo', 19, 'Case');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('Brazil', 23, 'centro-avante', 23, 'Yule');
insert into JOGADOR (PAIS, N_CAMISA, POSICAO , IDADE , NOME) values ('Russia', 46, 'meio campo', 21, 'Aubert');


-----------------------------------------------------
-- POVOAMENTO PARTIDA --
-----------------------------------------------------

insert into PARTIDA (COD_PARTIDA, PAIS_VISITANTE, PAIS_MANDANTE ) values (64, 'South Africa', 'Mexico');
insert into PARTIDA (COD_PARTIDA, PAIS_VISITANTE, PAIS_MANDANTE ) values (60, 'Russia', 'Brazil');
insert into PARTIDA (COD_PARTIDA, PAIS_VISITANTE, PAIS_MANDANTE ) values (18, 'United States', 'South Africa');
insert into PARTIDA (COD_PARTIDA, PAIS_VISITANTE, PAIS_MANDANTE ) values (63, 'Japan', 'Brazil');
insert into PARTIDA (COD_PARTIDA, PAIS_VISITANTE, PAIS_MANDANTE ) values (77, 'Mexico', 'Russia');
insert into PARTIDA (COD_PARTIDA, PAIS_VISITANTE, PAIS_MANDANTE ) values (80, 'Russia', 'United States');
insert into PARTIDA (COD_PARTIDA, PAIS_VISITANTE, PAIS_MANDANTE ) values (36, 'Brazil', 'Mexico');
insert into PARTIDA (COD_PARTIDA, PAIS_VISITANTE, PAIS_MANDANTE ) values (84, 'South Africa', 'Brazil');
insert into PARTIDA (COD_PARTIDA, PAIS_VISITANTE, PAIS_MANDANTE ) values (69, 'Brazil', 'Russia');
insert into PARTIDA (COD_PARTIDA, PAIS_VISITANTE, PAIS_MANDANTE ) values (34, 'Russia', 'Japan');


-----------------------------------------------------
-- POVOAMENTO ARBITRO--
-----------------------------------------------------

insert into ARBITRO  (ID_ARBITRO, NOME, NACIONALIDADE ) values (8, 'Carlos José', 'Argentine');
insert into ARBITRO  (ID_ARBITRO, NOME, NACIONALIDADE ) values (97, 'Mersey Euels', 'Russian');
insert into ARBITRO  (ID_ARBITRO, NOME, NACIONALIDADE ) values (36, 'Lee Ping', 'Chinese');
insert into ARBITRO  (ID_ARBITRO, NOME, NACIONALIDADE ) values (56, 'Julius Riche', 'American');
insert into ARBITRO  (ID_ARBITRO, NOME, NACIONALIDADE ) values (17, 'Kerk Coston', 'American');
insert into ARBITRO  (ID_ARBITRO, NOME, NACIONALIDADE ) values (48, 'Juan Mendez', 'Colombian');
insert into ARBITRO  (ID_ARBITRO, NOME, NACIONALIDADE ) values (73, 'Cord Jowsey', 'American');
insert into ARBITRO  (ID_ARBITRO, NOME, NACIONALIDADE ) values (100, 'Retha Olivey', 'Chinese');
insert into ARBITRO  (ID_ARBITRO, NOME, NACIONALIDADE ) values (7, 'Fátima Maria', 'Portuguese');
insert into ARBITRO  (ID_ARBITRO, NOME, NACIONALIDADE ) values (64, 'Jerry Tesseyman', 'New Zealander');


-----------------------------------------------------
-- POVOAMENTO ARBITRO_PRINCIPAL--
-----------------------------------------------------

insert into ARBITRO_PRINCIPAL  (ID_ARBITRO_PRINCIPAL) values (8);
insert into ARBITRO_PRINCIPAL  (ID_ARBITRO_PRINCIPAL) values (97);
insert into ARBITRO_PRINCIPAL  (ID_ARBITRO_PRINCIPAL) values (48);
insert into ARBITRO_PRINCIPAL  (ID_ARBITRO_PRINCIPAL) values (73);
insert into ARBITRO_PRINCIPAL  (ID_ARBITRO_PRINCIPAL) values (100);
insert into ARBITRO_PRINCIPAL  (ID_ARBITRO_PRINCIPAL) values (64);
insert into ARBITRO_PRINCIPAL  (ID_ARBITRO_PRINCIPAL) values (36);


-----------------------------------------------------
-- POVOAMENTO COMANDA -- rel 
-----------------------------------------------------
 
insert into COMANDA (COD_PARTIDA, ID_ARBITRO_PRINCIPAL) values (69, 8);
insert into COMANDA (COD_PARTIDA, ID_ARBITRO_PRINCIPAL) values (34, 100);
insert into COMANDA (COD_PARTIDA, ID_ARBITRO_PRINCIPAL) values (84, 73);
insert into COMANDA (COD_PARTIDA, ID_ARBITRO_PRINCIPAL) values (36, 97);
insert into COMANDA (COD_PARTIDA, ID_ARBITRO_PRINCIPAL) values (80, 36);
insert into COMANDA (COD_PARTIDA, ID_ARBITRO_PRINCIPAL) values (63, 64);
insert into COMANDA (COD_PARTIDA, ID_ARBITRO_PRINCIPAL) values (77, 48);
insert into COMANDA (COD_PARTIDA, ID_ARBITRO_PRINCIPAL) values (60, 36);
insert into COMANDA (COD_PARTIDA, ID_ARBITRO_PRINCIPAL) values (18, 97);
insert into COMANDA (COD_PARTIDA, ID_ARBITRO_PRINCIPAL) values (64, 8);


-----------------------------------------------------
-- POVOAMENTO SEDIA -- rel 
-----------------------------------------------------

insert into SEDIA (ID_ESTADIO, ANO) values (16,2018);
insert into SEDIA (ID_ESTADIO, ANO) values (11,2018);
insert into SEDIA (ID_ESTADIO, ANO) values (40,2002);
insert into SEDIA (ID_ESTADIO, ANO) values (32,2002);
insert into SEDIA (ID_ESTADIO, ANO) values (42,2014);
insert into SEDIA (ID_ESTADIO, ANO) values (13,2014);
insert into SEDIA (ID_ESTADIO, ANO) values (81,2010);
insert into SEDIA (ID_ESTADIO, ANO) values (77,2010);
insert into SEDIA (ID_ESTADIO, ANO) values (7,1994);
insert into SEDIA (ID_ESTADIO, ANO) values (34,1986);


-----------------------------------------------------
-- POVOAMENTO MASCOTE_COPA -- rel
-----------------------------------------------------

insert into MASCOTE_COPA (ANO, NOME, PAIS_SEDE) values (1994, 'Striker', 'United States);
insert into MASCOTE_COPA (ANO, NOME, PAIS_SEDE) values (1986, 'Pique', 'Mexico');
insert into MASCOTE_COPA (ANO, NOME, PAIS_SEDE) values (2002, 'Spheriks', 'Japan');
insert into MASCOTE_COPA (ANO, NOME, PAIS_SEDE) values (2018, 'Zabivaka', 'Russia');
insert into MASCOTE_COPA (ANO, NOME, PAIS_SEDE) values (2014, 'Fuleco', 'Brazil');
insert into MASCOTE_COPA (ANO, NOME, PAIS_SEDE) values (2010, 'Zakumi', 'South Africa');


-----------------------------------------------------
-- POVOAMENTO TEM -- rel
-----------------------------------------------------

insert into TEM (ANO, PAIS, ID_RANKING) values (1994, 'United States', 26);
insert into TEM (ANO, PAIS, ID_RANKING) values (1994, 'United States', 24);
insert into TEM (ANO, PAIS, ID_RANKING) values (2002, 'Japan', 21);
insert into TEM (ANO, PAIS, ID_RANKING) values (1986, 'Mexico', 2);
insert into TEM (ANO, PAIS, ID_RANKING) values (2014, 'Brazil', 29);
insert into TEM (ANO, PAIS, ID_RANKING) values (2018, 'Russia', 16);
insert into TEM (ANO, PAIS, ID_RANKING) values (2014, 'Brazil', 17);
insert into TEM (ANO, PAIS, ID_RANKING) values (2010, 'South Africa', 6);
insert into TEM (ANO, PAIS, ID_RANKING) values (2018, 'Russia', 29);
insert into TEM (ANO, PAIS, ID_RANKING) values (2010, 'South Africa', 14);
insert into TEM (ANO, PAIS, ID_RANKING) values (2014, 'Brazil', 13);
insert into TEM (ANO, PAIS, ID_RANKING) values (2010, 'South Africa', 27);
insert into TEM (ANO, PAIS, ID_RANKING) values (2018, 'Russia', 18);


-----------------------------------------------------
-- POVOAMENTO POSSUI -- rel
-----------------------------------------------------

insert into  POSSUI (ANO, ID_ARBITRO_PRINCIPAL) values (2002, 8);
insert into  POSSUI (ANO, ID_ARBITRO_PRINCIPAL) values (2018, 97);
insert into  POSSUI (ANO, ID_ARBITRO_PRINCIPAL) values (1986, 48);
insert into  POSSUI (ANO, ID_ARBITRO_PRINCIPAL) values (2010, 73);
insert into  POSSUI (ANO, ID_ARBITRO_PRINCIPAL) values (2014, 100);
insert into  POSSUI (ANO, ID_ARBITRO_PRINCIPAL) values (1994, 64);
insert into  POSSUI (ANO, ID_ARBITRO_PRINCIPAL) values (2002, 64);
insert into  POSSUI (ANO, ID_ARBITRO_PRINCIPAL) values (2014, 36);
insert into  POSSUI (ANO, ID_ARBITRO_PRINCIPAL) values (2010, 100);
insert into  POSSUI (ANO, ID_ARBITRO_PRINCIPAL) values (2018, 97);


-----------------------------------------------------
-- POVOAMENTO PUNICAO -- rel
-----------------------------------------------------

insert into  PUNICAO (COD_PARTIDA, ID_ARBITRO_PRINCIPAL, PAIS, N_CAMISA, COR_DO_CARTAO) values (18, 73, 'South Africa', 75, 'Yellow');
insert into  PUNICAO (COD_PARTIDA, ID_ARBITRO_PRINCIPAL, PAIS, N_CAMISA, COR_DO_CARTAO) values (63, 36, 'Brazil', 23, 'Yellow');
insert into  PUNICAO (COD_PARTIDA, ID_ARBITRO_PRINCIPAL, PAIS, N_CAMISA, COR_DO_CARTAO) values (64, 48, 'Mexico', 61, 'Red');
insert into  PUNICAO (COD_PARTIDA, ID_ARBITRO_PRINCIPAL, PAIS, N_CAMISA, COR_DO_CARTAO) values (77, 97, 'Russia', 49, 'Yellow');
insert into  PUNICAO (COD_PARTIDA, ID_ARBITRO_PRINCIPAL, PAIS, N_CAMISA, COR_DO_CARTAO) values (34, 8, 'Japan', 96, 'Red');
insert into  PUNICAO (COD_PARTIDA, ID_ARBITRO_PRINCIPAL, PAIS, N_CAMISA, COR_DO_CARTAO) values (69, 97, 'Russia', 60, 'Yellow');
insert into  PUNICAO (COD_PARTIDA, ID_ARBITRO_PRINCIPAL, PAIS, N_CAMISA, COR_DO_CARTAO) values (77, 97, 'Russia', 49, 'Red');
insert into  PUNICAO (COD_PARTIDA, ID_ARBITRO_PRINCIPAL, PAIS, N_CAMISA, COR_DO_CARTAO) values (80, 64, 'United States', 17, 'Red');
insert into  PUNICAO (COD_PARTIDA, ID_ARBITRO_PRINCIPAL, PAIS, N_CAMISA, COR_DO_CARTAO) values (80, 64, 'United States', 29, 'Yellow');
insert into  PUNICAO (COD_PARTIDA, ID_ARBITRO_PRINCIPAL, PAIS, N_CAMISA, COR_DO_CARTAO) values (84, 100, 'Brazil', 23, 'Red');
