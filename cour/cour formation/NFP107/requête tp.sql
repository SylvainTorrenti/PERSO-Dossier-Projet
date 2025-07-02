--2.Établir la liste des avions qui appartiennent à un type d'appareil dont le premier caractère du code type est '7'. 
--Afficher les numéros d'avion et les types.

select numavion, fk_typeappareil
from avion 
where fk_typeappareil like '7%';

--3.Afficher les numéros des vols qui ont eu lieu le 2 mars 2004

select fk_numvol
from vol_realise
where date = '2004-03-02';

--4.Donner la liste des pilotes qui ne perçoivent pas de commission et qui ont un salaire supérieur à 20000. 
--Afficher le nom du pilote et son salaire.

select nom, salaire, commission
from pilote
where commission is null and salaire >20000::money;

--5.Donner la liste alphabétique des pilotes qui habitent Paris et qui ont été embauchés avant le 1 janvier 2001 
--ou après le 1 janvier 2008. 
--Afficher les noms des pilotes, leur date d'embauche et leur adresse.

select pilote.nom, date_embauche, ville.nom as villeHabitation
from pilote
inner join ville on pilote.fk_ville = ville.code
--where date_embauche < '2001-01-01' or date_embauche > '2008-01-01';
where date_embauche not between'2001-01-01' and '2008-01-01' and upper (ville.nom)='PARIS'
order by pilote.nom;

--6. Donner la liste alphabétique des pilotes qui ont effectué un vol le 2 mars 2004. 
--Afficher le nom du pilote, le numéro de vol, la ville de départ et la ville d'arrivée.

select pilote.nom , vr.fk_numvol, villeDep.nom, villeArr.nom
from pilote
inner join vol_realise vr on pilote.numpilote = vr.fk_numpilote and vr.date = '2004-03-02'
inner join vol on vr.fk_numvol = vol.numvol
inner join ville villeDep on fk_vildep = villeDep.code
inner join ville villeArr on fk_vilarr = villeArr.code
--where vr.date = '2004-03-02'
order by pilote.nom;

--7.Établir la liste des vols qui arrivent à Londres avant 12:00. 
--Afficher le numéro de vol, la ville de départ, l'heure de départ et l'heure d'arrivée. 
--La liste sera présentée par ordre alphabétique des villes de départ et par heures de départ croissantes.

select vol.numvol, villeDep.nom, vol.dep, vol.arr
from vol
inner join ville villeDep on fk_vildep = villeDep.code
inner join ville villeArr on fk_vilarr = villeArr.code
where upper(villeArr.nom) ='LONDRES' and vol.arr <  '12:00:00'
order by villeDep.nom, vol.dep asc;

--8.Afficher tout les vols par ordre alphabétique des villes de départ et par heures de départ décroissant. 

select *
from vol
inner join ville villeDep on fk_vildep = villeDep.code
order by villeDep.nom asc, vol.dep desc;

--9.Donner pour chaque pilote qui habite à Lyon 
--et qui utilise un avion totalisant moins de 12000 heures de vol, le type d'appareil correspondant. 
--Afficher le nom du pilote et le libellé du type d'appareil.

select distinct pilote.nom, type_appareil.nom
from pilote
inner join ville on pilote.fk_ville = ville.code
inner join vol_realise on vol_realise.fk_numpilote = pilote.numpilote
inner join avion on vol_realise.fk_numavion = avion.numavion
inner join type_appareil on avion.fk_typeappareil = type_appareil.typeappareil
inner join vol on vol.numvol = vol_realise.fk_numvol
where avion.nbhvol < 12000 and upper(ville.nom) ='LYON';

--10.Donner pour chaque pilote de la base de données, la liste des villes à partir desquelles 
--il a effectué un vol. 
--Afficher le numéro du pilote, le nom du pilote, et la ville de départ.

select distinct pilote.numpilote, pilote.nom, ville.nom as villeDepart
from pilote
inner join vol_realise on vol_realise.fk_numpilote = pilote.numpilote
inner join vol on vol_realise.fk_numvol = vol.numvol
inner join ville on vol.fk_vildep = ville.code;

--Donner pour chaque pilote de la base de données, 
--la liste des villes à partir desquelles il n'a jamais décollé. 
--Afficher le numéro du pilote, le nom du pilote et la ville.

select pilote.numpilote, pilote.nom, ville.nom
from pilote, ville
where (numpilote, ville.code) not in (
							select distinct pilote.numpilote, ville.code
							from pilote
							inner join vol_realise on vol_realise.fk_numpilote = pilote.numpilote
							inner join vol on vol_realise.fk_numvol = vol.numvol
							inner join ville on vol.fk_vildep = ville.code
);

select pilote.numpilote, pilote.nom, ville.nom
from pilote, ville
except 
		select distinct pilote.numpilote, pilote.nom, ville.nom
		from pilote
		inner join vol_realise on vol_realise.fk_numpilote = pilote.numpilote
		inner join vol on vol_realise.fk_numvol = vol.numvol
		inner join ville on vol.fk_vildep = ville.code;

select p1.numpilote, p1.nom, v1.nom
from pilote p1, ville v1
where not exists (
							select distinct pilote.numpilote, ville.code
							from pilote 
							inner join vol_realise on vol_realise.fk_numpilote = pilote.numpilote
							inner join vol on vol_realise.fk_numvol = vol.numvol
							inner join ville on vol.fk_vildep = ville.code
							where pilote.numpilote = p1.numpilote and ville.code = v1.code
);

--12. Donner la liste des vols qui correspondent à des aller-retours entre deux villes. 
--Afficher les numéros de vol, la ville de départ et la ville d'arrivée.

select v1.numvol, v2.numvol, villeDep.nom, villeArr.nom 
from vol v1
inner join vol v2 on v1.fk_vildep = v2.fk_vilarr and v1.fk_vilarr=v2.fk_vildep
inner join ville villeDep on v1.fk_vildep = villeDep.code
inner join ville villeArr on v2.fk_vildep = villeArr.code;

--13. Donner pour chaque pilote qui est passé par Paris, le numéro de vol et la date correspondante. 
--Afficher le numéro du pilote, le nom du pilote, le numéro de vol et la date du vol.

select pilote.numpilote, pilote.nom, vol.numvol, vol_realise.date
from pilote
inner join vol_realise on vol_realise.fk_numpilote = pilote.numpilote
inner join vol on vol.numvol = vol_realise.fk_numvol
inner join ville villeDep on vol.fk_vildep = villeDep.code
inner join ville villeArr on vol.fk_vilarr = villeArr.code
where upper(villeDep.nom) = 'PARIS' or upper(villeArr.nom) = 'PARIS';

--14. Donner la liste des appareils qui sont utilisés pour la liaison Lyon – Londres. 
--Affiché le code type et le libellé de l'appareil.

select type_appareil.typeappareil, type_appareil.nom
from type_appareil
inner join avion on avion.fk_typeappareil = type_appareil.typeappareil
inner join vol_realise on vol_realise.fk_numavion = avion.numavion
inner join vol on vol.numvol = vol_realise.fk_numvol
inner join ville villeDep on vol.fk_vildep = villeDep.code and upper(villeDep.nom) = 'LYON'
inner join ville villeArr on vol.fk_vilarr = villeArr.code and upper(villeArr.nom) = 'LONDRES';

--15. Établir la liste des avions qui sont partis au moins une fois de Paris ou au moins une fois de Lyon. 
--Afficher uniquement les numéros d'avion.

select distinct avion.numavion
from avion
	where numavion in (select fk_numavion
						from vol_realise
						inner join vol on fk_vol = numvol
						inner join ville on fk_vildep = ville.code and upper(ville.nom) = 'PARIS'
						)
and 
where numavion in (select fk_numavion
						from vol_realise
						inner join vol on fk_vol = numvol
						inner join ville on fk_vildep = ville.code and upper(ville.nom) = 'LYON'
						);
