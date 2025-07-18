-- Suppression des tables
DROP TABLE IF EXISTS ville CASCADE;
DROP TABLE IF EXISTS vol CASCADE;
DROP TABLE IF EXISTS pilote CASCADE;
DROP TABLE IF EXISTS avion CASCADE;
DROP TABLE IF EXISTS type_appareil CASCADE;
DROP TABLE IF EXISTS vol_realise CASCADE;


CREATE TABLE ville (
	code CHAR(5) PRIMARY KEY,
	nom VARCHAR(40) UNIQUE
);

CREATE TABLE vol (
	numvol INT PRIMARY KEY,
	fk_vildep CHAR(5) NOT NULL, 
	fk_vilarr CHAR(5) NOT NULL,
	dep Time, 
	arr Time
);

CREATE TABLE pilote (
	numpilote INT PRIMARY KEY,
	nom VARCHAR(30),
	fk_ville CHAR(5) NOT NULL,
	salaire MONEY NOT NULL,
	commission MONEY,
	date_embauche DATE
);

CREATE TABLE avion (
	numavion INTEGER PRIMARY KEY,
	annserv INTEGER,
	nom VARCHAR(40) UNIQUE,
	nbhvol INTEGER CHECK (nbhvol >= 0),
	fk_typeappareil CHAR(5) NOT NULL
);

CREATE TABLE type_appareil (
	typeappareil CHAR(5) PRIMARY KEY,
	nom VARCHAR(40),
	nbplaces SMALLINT
);

CREATE TABLE vol_realise (
	id SERIAL PRIMARY KEY,
	fk_numvol INTEGER NOT NULL,
	fk_numavion INTEGER NOT NULL,
	fk_numpilote INTEGER NOT NULL,
	date DATE,
	heure_debut TIME,
	heure_fin TIME,
	nbpassagers INTEGER
);

-- Création des contraintes de clés étrangères
ALTER TABLE vol ADD CONSTRAINT constraint_fk_vildep FOREIGN KEY (fk_vildep) REFERENCES ville (code);
ALTER TABLE vol ADD CONSTRAINT constraint_fk_vilarr FOREIGN KEY (fk_vilarr) REFERENCES ville (code);

ALTER TABLE pilote ADD CONSTRAINT constraint_fk_ville FOREIGN KEY (fk_ville) REFERENCES ville (code);

ALTER TABLE avion ADD CONSTRAINT constraint_fk_typeappareil FOREIGN KEY (fk_typeappareil) REFERENCES type_appareil (typeappareil);

ALTER TABLE vol_realise ADD CONSTRAINT constraint_fk_numvol FOREIGN KEY (fk_numvol) REFERENCES vol (numvol);
ALTER TABLE vol_realise ADD CONSTRAINT constraint_fk_numavion FOREIGN KEY (fk_numavion) REFERENCES avion (numavion);
ALTER TABLE vol_realise ADD CONSTRAINT constraint_fk_numpilote FOREIGN KEY (fk_numpilote) REFERENCES pilote (numpilote);





