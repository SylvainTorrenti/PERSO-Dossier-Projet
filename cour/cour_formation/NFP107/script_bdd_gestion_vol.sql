--supression des tables si elles existent
drop table if exists ville cascade;
drop table if exists vol cascade;
drop table if exists pilote cascade;
drop table if exists avion cascade;
drop table if exists type_appareil cascade;
drop table if exists vol_realise cascade;


create table ville(
	code char(5) primary key,
	nom varchar(40) unique
);

create table vol (
	numvol int primary key,
	fk_villdep char(5) not null,
	fk_villar char(5) not null,
	dep time,
	ar time
);

create table pilote (
	numpilote int primary key,
	nom varchar(40),
	fk_ville char(5) not null,
	salaire money not null,
	comission money,
	dateembauche date
);

create table avion (
	numavion int primary key,
	annserv int,
	nom varchar(40) unique,
	nbhvol int check (nbhvol >= 0),
	fk_typeappareil char(5) not null
);

create table type_appareil (
	typeappareil char(5) primary key,
	nom varchar (40),
	nbplaces smallint 
);

create table vol_realise (
	id serial primary key,
	datevol date,
	heure_debut time,
	heure_fin time,
	fk_numvol int not null,
	fk_numavion int not null,
	fk_numpilote int not null
);

--creation des clés étrangére

alter table vol add constraint constraint_fk_vildep foreign key (fk_villdep) references ville(code);
alter table vol add constraint constraint_fk_vilar foreign key (fk_villar) references ville(code);
alter table pilote add constraint constraint_fk_ville foreign key (fk_ville) references ville(code);
alter table avion add constraint constraint_fk_typeappareil foreign key (fk_typeappareil) references type_appareil(typeappareil);
alter table vol_realise add constraint constraint_fk_numvol foreign key (fk_numvol) references vol(numvol);
alter table vol_realise add constraint constraint_fk_numavion foreign key (fk_numavion) references avion(numavion);
alter table vol_realise add constraint constraint_fk_numpilote foreign key (fk_numpilote) references pilote(numpilote);


