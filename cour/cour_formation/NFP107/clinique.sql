VILLE (ville, departement, nombreHabitants)
CLINIQUE (numeroClinique, nom, nombreLits, ville)
SPECIALITE (numeroSpecialite, libelle)
SERVICE (numeroSpecialite, numeroClinique)


a) Donner la liste des cliniques ayant un nombre de lits inférieur à 500.
SELECT *
FROM clinique
WHERE nombreLits < 500;

b) Donner le nom des cliniques qui propose la spécialité numéro 100.
SELECT nom
FROM clinique
INNER JOIN service ON clinique.numeroClinique = service.numeroClinique
WHERE service.numeroSpecialite = 100;

c) Donner le nom des cliniques des villes de plus de 500 000 habitants du département du Rhône, qui ont plus de 100 lits.
SELECT nom
FROM clinique INNER JOIN clinique.ville = ville.ville 
WHERE ville.nombreHabitants > 500000 AND departement = 'Rhône' AND nombreLits > 100;

d) Donner pour chaque ville, le nom de la clinique qui a le plus grand nombre de lits.
SELECT ville.ville, clinique.nom 
FROM ville inner join clinique on clinique.ville = ville.ville
where clinique.nombreLits = (select max(nombreLits) from clinique c2 where c2.ville = ville.ville);

e) Donner le nom des cliniques qui disposent des spécialités 100 et/ou 600.
SELECT nom
FROM clinique
INNER JOIN service ON clinique.numeroClinique = service.numeroClinique
-- WHERE service.numeroSpecialite = 100 OR  service.numeroSpecialite = 600;
WHERE service.numeroSpecialite IN (100, 600);

f) Donner le nom des cliniques qui disposent à la fois des spécialités 100, 600 et 700.
SELECT nom
FROM clinique
WHERE EXISTS (SELECT 1 FROM service WHERE clinique.numeroClinique = service.numeroClinique AND numeroSpecialite = 100)
AND EXISTS (SELECT 1 FROM service WHERE clinique.numeroClinique = service.numeroClinique AND numeroSpecialite = 600)
AND EXISTS (SELECT 1 FROM service WHERE clinique.numeroClinique = service.numeroClinique AND numeroSpecialite = 700)

g) Donner pour chaque département le nom de la spécialité la plus représentée.

SELECT departement, libelle, count(*) as nb
FROM ville INNER JOIN clinique ON clinique.ville = ville.ville
INNER JOIN service ON service.numeroClinique = clinique.numeroClinique
INNER JOIN specialite ON service.numeroSpecialite = specialite.numeroSpecialite
group by departement, libelle, service.numeroSpecialite
HAVING count(*) = (
	SELECT count(*) 
	FROM ville v2 INNER JOIN clinique ON clinique.ville = v2.ville
	INNER JOIN service ON service.numeroClinique = clinique.numeroClinique
	INNER JOIN specialite ON service.numeroSpecialite = specialite.numeroSpecialite
	where v2.departement = ville.departement
	group by departement, service.numeroSpecialite
	order by count(*) desc limit 1	
)

-- version proposée par ChatGPT
SELECT v.departement, s.libelle
FROM VILLE v
JOIN CLINIQUE c ON v.ville = c.ville
JOIN SERVICE se ON c.numeroClinique = se.numeroClinique
JOIN SPECIALITE s ON se.numeroSpecialite = s.numeroSpecialite
GROUP BY v.departement, s.libelle
HAVING COUNT(*) = (
    SELECT MAX(nbSpec)
    FROM (
        SELECT COUNT(*) AS nbSpec
        FROM VILLE v2
        JOIN CLINIQUE c2 ON v2.ville = c2.ville
        JOIN SERVICE se2 ON c2.numeroClinique = se2.numeroClinique
        WHERE v2.departement = v.departement
        GROUP BY se2.numeroSpecialite
    ) tmp
);


h) Donner le nom des villes dans lesquelles il n’y a pas de clinique.
SELECT ville
FROM ville LEFT JOIN clinique on ville.ville = clinique.ville
WHERE clinique.numeroClinique IS NULL;

SELECT ville
FROM ville 
WHERE NOT EXISTS (SELECT 1 FROM clinique WHERE ville.ville = clinique.ville);

SELECT ville
FROM ville 
WHERE NOT ville IN (SELECT clinique.ville FROM clinique);


