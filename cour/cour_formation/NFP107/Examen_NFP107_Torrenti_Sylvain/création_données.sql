insert into Etudiant [(code) ,(nom), (prenom)]
values 
(1,'Dho','Bob')
(2,'Doe','Julie')
(3,'Deo','Alice')

insert into Porte [(code),(libelle)]
values
('PHY01','porte laboratoire de Physique')
('AMPH002','porte amphithéatre')

insert into Salle [(code),(nom),(fk_codePorte)]
values
('PHY','Labo de physique','PHY01')

delete from Porte CASCADE
where code = AMPH02;