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
-- 16. Donner la liste des pilotes qui ont le même nom et une adresse différente. 
--Afficher le nom et l'adresse du pilote.

select p1.nom , p1.fk_ville, p2.fk_ville
from pilote p1
inner join pilote p2 on p1.nom = p2.nom and p1.fk_ville <> p2.fk_ville;

--17. Liste des pilotes qui habitent dans une ville de départ 
--d'un vol desservi par un avion de code type '747'.

select *
from pilote
where
fk_ville in (select vol.fk_vildep
			from avion
			inner join vol_realise on fk_numavion = avion.numavion
			inner join vol on fk_numvol = vol.numvol
			where avion.fk_typeappareil = '747');


--  creation vue de vol pour lier les noms de villes
create or replace view vue_vol as
select vol.*, vdep.nom as vildep, varr.nom as vilarr
from vol
inner join ville vdep on fk_vildep = vdep.code
inner join ville varr on fk_vildep = varr.code;


--18. Liste des vols ayant un pilote qui habite la ville de départ du vol. 
--Afficher le numéro de vol, la ville de départ, la ville d'arrivée et le nom du pilote.

select v.numvol, vildep, vilarr, pilote.nom
from vue_vol v
inner join pilote on fk_ville = v.fk_vildep;

--19. Liste des pilotes affecté à aucun vol.
select *
from pilote
where not numpilote in (select fk_numpilote from vol_realise);

--20. Liste des avions de même type que l'avion '747' et mis en service la même année.
select annserv, count(*)
from avion
where fk_typeappareil = '747'
group by annserv;

--21. nombre de 747 mis en service par an. 
--ne retournez que les anné de plus un 747
select annserv, count(*)
from avion
where fk_typeappareil = '747'
group by annserv
having count(*);

--23. Liste des avions de même type que l'avion n°20 et mis en service la même année.
select * 
from avion
where fk_typeappareil =(select fk_typeappareil 
						from avion 
						where numavion = 20);

--24. Donner la liste des avions qui n'ont pas volé le 2 mars 2004. 
--Afficher le numéro et le nom des avions.
select avion.numavion, avion.nom
from avion
where numavion not in (select fk_numavion
						from vol_realise
						where date = '2004-03-02');

--25. Donner la liste des pilotes qui ont été embauché après le pilote numéro ‘000008’. 
--Afficher le numéro et le nom des pilotes.
select *
from pilote
where date_embauche >= (select date_embauche from pilote where numpilote = 8);

--26 Quels sont les avions qui sont partis de Boissey ou de Chanay. Afficher les numéros et les noms.
select avion.*
from avion
inner join vol_realise on numavion = fk_numavion
inner join vue_vol on fk_numvol = vue_vol.numvol
where upper(vildep) = 'BOISSEY' or upper (vildep) = 'CHANAY';

--27 quels sont les avions qui sont partis au moins une fois de Boissey et au moins une fois de Chanay.
select avion.*
from avion
inner join vol_realise on numavion = fk_numavion
inner join vue_vol on fk_numvol = vue_vol.numvol
where upper(vildep) = 'BOISSEY' 
and numavion in (select numavion
					from avion
					inner join vol_realise on numavion = fk_numavion
					inner join vue_vol on fk_numvol = vue_vol.numvol
					where (vildep) = 'CHANAY');

--28 donner la liste des vols pour lesquels au moins un pilote ayant effectué la liaison 
--habite la ville d'arrivé. affiche numero de vol, ville de daprt, ville d'arrivée
select *
from vol
where exists ( select 1
				from vol_realise
				inner join pilote on numpilote = fk_numpilote
				where fk_numvol = vol.numvol and pilote.fk_ville = vol.fk_vildep);

--29 Donner le numéro, le nom et le salaire du pilote qui a le salaire le plus élevé.
select * 
from pilote
where salaire = (select max(salaire)from pilote);

--30 Donner le numéro, le nom et le montant de la commission du pilote 
--qui a la plus faible commission non nulle.
select * 
from pilote
where commission = (select min(commission) from pilote);

--31 Établir la liste des pilotes qui ont volé sur tous les types d'avions excepté le type Z12. 
--Afficher le numéro et le nom des pilotes.

--32 Donner le nombre de jours qui sépare la date d'embauche du premier pilote 
--embauché et la date d'embauche du dernier pilote embauché.
select min(date_embauche)
from pilote;
select max(date_embauche)
from pilote;
select max(date_embauche) - min (date_embauche) as nbjourdiff from pilote;

--33 Donner le taux de remplissage des avions pour chaque vol. 
--Afficher le numéro du vol, les villes de départ et d'arrivée, 
--la date du vol et le taux de remplissage sous la forme d'un pourcentage.
select vol.numvol, villdep.nom as villdep, villarr.nom as villarr, vr.date, round((vr.nbpassagers::numeric / ta.nbplaces::numeric) * 100,2) as Taux_remplissage
from vol_realise vr
inner join vol on vr.fk_numvol = vol.numvol
inner join avion on vr.fk_numavion = avion.numavion
inner join type_appareil ta on ta.typeappareil = avion.fk_typeappareil
inner join ville villdep on villdep.code = vol.fk_vildep
inner join ville villarr on villarr.code = vol.fk_vilarr;

--34 Donner pour chaque pilote, son numéro, son nom, sa date d'embauche, la date de son premier vol.
select pilote.numpilote, pilote.nom, pilote.date_embauche , min(vr.date)
from pilote
inner join vol_realise vr on pilote.numpilote = vr.fk_numpilote
group by pilote.numpilote, pilote.nom, pilote.date_embauche

--35 Donner le jour de la semaine (lundi, mardi, …) d'embauche de chaque pilote. 
--Afficher le numéro du pilote, son nom et son jour d'embauche.
select numpilote, nom, to_char(date_embauche, 'Day')
from pilote
order by nom;

--36 Indiquer pour chaque pilote qui reçoit une commission, le montant le plus élevé 
--entre salaire et commission. 
--Afficher le numéro du pilote, le nom, « Salaire » ou « Commission » et le montant correspondant.
select numpilote, nom,salaire, commission,
		case
			when commission > salaire then 'Commission'
			when salaire > commission or commission is  null then 'Salaire'
			else 'Identique'
		end as libbeleMax,
		case
			when commission > salaire then commission
			when salaire > commission then salaire
			else salaire
		end as ValeurMax
from pilote
order by nom;
			
--37 Donner la liste des pilotes embauchés le même mois et la même année que le pilote numéro '000011'. 
--Afficher le numéro, le nom, le mois et l'année d'embauche du pilote.
select *
from pilote
where (extract(month from date_embauche), extract(year from date_embauche)) = 
		(select extract(month from date_embauche), extract(year from date_embauche) from pilote where numpilote = 11)
			and numpilote <> 11;

--38 Donner le nombre d'avion et le nombre moyen d'heures de vol par type d'avion.
select fk_typeappareil, count(*), round(avg(nbhvol),2)
from avion
group by fk_typeappareil;

--39 Donner le taux moyen de remplissage des avions de type '747'.
select round(avg(vr.nbpassagers::numeric / ta.nbplaces::numeric) * 100,2) as txRemp
from vol_realise vr
inner join avion on fk_numavion = numavion
inner join type_appareil ta on fk_typeappareil = typeappareil and typeappareil = '747';

--40 Afficher le numéro et le nom du dernier pilote embauché
select numpilote, nom
from pilote
where date_embauche = (select max(date_embauche)
						from pilote);

--41 Donner le nombre de vols différents auquel le pilote numéro '000008' a été affecté.
select count(distinct fk_numvol)
from vol_realise
where fk_numpilote = 8;

--42 Donner la liste des avions qui ont été pilotés par plus de deux pilotes. 
--Afficher le numéro des avions et le nom des pilotes. 
select distinct pilote.nom, fk_numavion
from vol_realise
inner join pilote on fk_numpilote = numpilote
where fk_numavion in (select fk_numavion
						from vol_realise 
						group by fk_numavion
						having count(distinct fk_numpilote) >=2)
order by fk_numavion;



				



