INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_gouvernement', 'Gouvernement', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_gouvernement', 'Gouvernement', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_gouvernement', 'Gouvernement', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('gouv', 'Gouvernement')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('gouv',0,'secu','Garde du corps',12,'{}', '{}'),
	('gouv',1,'secuchef','Chef sécurité',24,'{}', '{}'),
	('gouv',2,'avocat','Avocat',24,'{}', '{}'),
	('gouv',3,'proc','Procureur',36,'{}', '{}'),
	('gouv',4,'juge',"Juge",48,'{}', '{}'),
	('gouv',5,'secretaire',"Inspecteur du travail",48,'{}', '{}'),
	('gouv',6,'viceboss',"Conseiller général",48,'{}', '{}'),
	('gouv',7,'boss','Gouverneur',0,'{}', '{}')
;

