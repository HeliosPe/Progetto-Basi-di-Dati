CREATE DATABASE IF NOT EXISTS food_delivery;
USE food_delivery;

CREATE TABLE Cliente (
    username VARCHAR (50) PRIMARY KEY ,
    nome VARCHAR (50) NOT NULL ,
    cognome VARCHAR (50) NOT NULL ,
    data_nascita DATE NOT NULL ,
    email VARCHAR (100) UNIQUE NOT NULL ,
    password VARCHAR (100) NOT NULL ,
    numero_civico VARCHAR (10) ,
    via VARCHAR (100) ,
    cap VARCHAR (5) ,
    saldo DECIMAL (10 ,2) DEFAULT 0 ,
    carta_fedelta VARCHAR (30) ,
    lingua VARCHAR (30)
);

CREATE TABLE Ordine (
    id INT PRIMARY KEY ,
    numero_civico VARCHAR (10) ,
    via VARCHAR (100) ,
    cap VARCHAR (10) ,
    voto_servizio INT CHECK ( voto_servizio BETWEEN 1 AND 5) ,
    orario_ordinazione TIME ,
    data_ordinazione DATE NOT NULL ,
    orario_consegna TIME ,
    rider VARCHAR (10) ,
    ristorante VARCHAR (50) NOT NULL ,
    cliente VARCHAR (50) ,
    FOREIGN KEY ( rider ) REFERENCES Rider ( matricola ) ,
    FOREIGN KEY ( ristorante ) REFERENCES Ristorante ( id )
    FOREIGN KEY ( cliente ) REFERENCES Cliente ( username )
);

CREATE TABLE Ticket (
    id INT PRIMARY KEY ,
    cliente VARCHAR (50) NOT NULL ,
    FOREIGN KEY ( cliente ) REFERENCES Cliente ( username ) ,
);

CREATE TABLE Ricevuta (
    data DATE ,
    ticket INT ,
    testo VARCHAR (1500)
    mittente VARCHAR (50)
    FOREIGN KEY ( ticket ) REFERENCES Ticket ( id ) ,
    PRIMARY KEY ( data , ticket )
);

CREATE TABLE Operatore (
    matricola VARCHAR (10) PRIMARY KEY ,
    nome VARCHAR (50) NOT NULL ,
    cognome VARCHAR (50) NOT NULL ,
    data_nascita DATE NOT NULL ,
    luogo_nascita VARCHAR (100) NOT NULL
    email VARCHAR (100) UNIQUE NOT NULL ,
    password VARCHAR (255) NOT NULL ,
    giorni_lavoro VARCHAR (100) ,
    fasce_orarie VARCHAR (100) ,
    salario DECIMAL (10 ,2)
    numero_civico VARCHAR (10) ,
    via VARCHAR (100) ,
    cap VARCHAR (5) ,
    lingue VARCHAR (500)
);

CREATE TABLE Rider (
    matricola VARCHAR (10) PRIMARY KEY ,
    nome VARCHAR (50) NOT NULL ,
    cognome VARCHAR (50) NOT NULL ,
    data_nascita DATE NOT NULL ,
    luogo_nascita VARCHAR (100) NOT NULL
    email VARCHAR (100) UNIQUE NOT NULL ,
    password VARCHAR (255) NOT NULL ,
    giorni_lavoro VARCHAR (100) ,
    fasce_orarie VARCHAR (100) ,
    salario DECIMAL (10 ,2) ,
    numero_civico VARCHAR (10) ,
    via VARCHAR (100) ,
    cap VARCHAR (5) ,
    lingua VARCHAR (30) ,
    fotografia VARCHAR (100)
);

CREATE TABLE Ricevuta (
    id INT PRIMARY KEY ,
    metodo_pagamento VARCHAR (50) NOT NULL ,
    codice_sconto VARCHAR (30) ,
    importo_complessivo DECIMAL (10 ,2) NOT NULL ,
    prezzo_consegna DECIMAL (10 ,2) NOT NULL ,
    mancia DECIMAL (10 ,2) ,
    iva DECIMAL (5 ,2) NOT NULL
    ordine INT NOT NULL
    FOREIGN KEY ( ordine ) REFERENCES Ordine ( id ) ,
);

CREATE TABLE Menu (
    nome VARCHAR (100) PRIMARY KEY ,
    ristorante INT NOT NULL ,
    FOREIGN KEY ( ristorante ) REFERENCES Ristorante ( id )
);

CREATE TABLE Ristorante (
    id INT PRIMARY KEY ,
    numero_civico VARCHAR (10) ,
    via VARCHAR (100) ,
    cap VARCHAR (5) ,
    tipologia VARCHAR (50) ,
    media DECIMAL (1 ,2) CHECK ( media >= 1.00 AND media <=
    5.00) ,
    nome VARCHAR (100)
);

CREATE TABLE Piatto (
    nome VARCHAR (100) ,
    ristorante INT NOT NULL ,
    prezzo DECIMAL (10 ,2) NOT NULL ,
    PRIMARY KEY ( nome , ristorante ) ,
    FOREIGN KEY ( ristorante ) REFERENCES Ristorante ( id )
);

CREATE TABLE Ingrediente (
    nome VARCHAR (100) PRIMARY KEY
);

CREATE TABLE Assistenza (
    ticket INT NOT NULL ,
    operatore VARCHAR (5100) NOT NULL ,
    FOREIGN KEY ( ticket ) REFERENCES Ticket ( id ) ,
    FOREIGN KEY ( operatore ) REFERENCES Operatore ( matricola )
);

CREATE TABLE Contiene (
    nome_piatto VARCHAR (100) NOT NULL ,
    ristorante INT NOT NULL ,
    ingrediente VARCHAR (100) ,
    PRIMARY KEY ( nome_piatto , ristorante , ingrediente ) ,
    FOREIGN KEY ( nome_piatto , ristorante ) REFERENCES Piatto ( nome ,
    ristorante ) ,
    FOREIGN KEY ( ingrediente ) REFERENCES Ingrediente ( nome )
);

CREATE TABLE Comprende (
    menu VARCHAR (100) ,
    nome_piatto VARCHAR (100) ,
    ristorante VARCHAR (100) ,
    PRIMARY KEY ( menu , nome_piatto , ristorante ) ,
    FOREIGN KEY ( menu , ristorante ) REFERENCES Menu ( nome ,
    ristorante ) ,
    FOREIGN KEY ( nome_piatto , ristorante ) REFERENCES Piatto ( nome ,
    ristorante )
);

CREATE TABLE Promuove (
    ristorante INT NOT NULL ,
    nome_piatto VARCHAR (100) ,
    sconto DECIMAL (5 ,2) ,
    periodo VARCHAR (50) ,
    PRIMARY KEY ( ristorante , nome_piatto ) ,
    FOREIGN KEY ( ristorante ) REFERENCES Ristorante ( nome ) ,
    FOREIGN KEY ( nome_piatto , ristorante ) REFERENCES Piatto ( nome ,
    ristorante )
);

CREATE TABLE Recensione (
    ordine INT NOT NULL ,
    ristorante INT NOT NULL ,
    PRIMARY KEY ( ordine , ristorante ) ,
    FOREIGN KEY ( ordine ) REFERENCES Ordine ( id ) ,
    FOREIGN KEY ( ristorante ) REFERENCES Ristorante ( id )
);