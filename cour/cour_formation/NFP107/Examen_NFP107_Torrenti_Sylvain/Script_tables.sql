--supression des tables si elles existent
drop table if exists Badge cascade;
drop table if exists HistoriqueAcces cascade;
drop table if exists Porte cascade;
drop table if exists Groupe cascade;
drop table if exists Salle cascade;
drop table if exists Etudiant cascade;
drop table if exists Enseignant cascade;

create type public.StatutAcces as enum ('REFUS','AUTORISATION')

create table Badge(
	numero integer primary key,
	fk_codeEtudiant integer,
	fk_codeEnseignant integer
);

create table HistoriqueAcces (
	fk_numeroBadge integer primary key,
	fk_codePorte integer primary key,
	dateAcces Date,
	acces StatutAcces
);

create table Porte (
	code varchar(40) primary key,
	libelle varchar(40)
);

create table Groupe (
	code integer primary key,
	libelle varchar(40),
	fk_codePorte varchar(40),
	fk_codeEtudiant integer,
	fk_codeEnseignant integer
);

create table Salle (
	code varchar(40) primary key,
	nom varchar(40),
	fk_codePorte varchar(40)
);

create table Etudiant (
	code integer primary key,
	nom varchar(40),
	prenom varchar(40)
);

create table Enseignant (
	code integer primary key,
	nom varchar(40),
	prenom varchar(40)
);

--creation des clés étrangére

alter table Badge add constraint constraint_fk_codeEtudiant foreign key (fk_codeEtudiant) references Etudiant(code);
alter table Badge add constraint constraint_fk_codeEnseignant foreign key (fk_codeEnseignant) references Enseignant(code);
alter table HistoriqueAcces add constraint constraint_fk_numeroBadge foreign key (fk_numeroBadge) references Badge(numeroBadge);
alter table HistoriqueAcces add constraint constraint_fk_codePorte foreign key (fk_codePorte) references Porte(code);
alter table Groupe add constraint constraint_fk_codePorte foreign key (fk_codePorte) references Porte(code);
alter table Groupe add constraint constraint_fk_codeEtudiant foreign key (fk_codeEtudiant) references Etudiant(code);
alter table Groupe add constraint constraint_fk_codeEnseignant foreign key (fk_codeEnseignant) references Enseignant(code);
alter table Salle add constraint constraint_fk_codePorte foreign key (fk_codePorte) references Porte(code);


