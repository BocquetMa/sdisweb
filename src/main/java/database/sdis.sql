-- Script SQL pour créer la base de données sdis
CREATE DATABASE IF NOT EXISTS sdis;
USE sdis;

-- Structure de la table `caserne`
DROP TABLE IF EXISTS `caserne`;
CREATE TABLE IF NOT EXISTS `caserne` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `rue` varchar(100) DEFAULT NULL,
  `copos` varchar(5) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `caserne`
INSERT INTO `caserne` (`id`, `nom`, `rue`, `copos`, `ville`) VALUES
(1, 'Ifs', '12 rue des Pompiers', '14123', 'Ifs'),
(2, 'Lisieux', '5 avenue du Feu', '14100', 'Lisieux'),
(3, 'Le Hom', '8 boulevard des Secours', '14220', 'Le Hom'),
(4, 'Caen Folie Couvrechef', '25 rue de l Urgence', '14000', 'Caen');

-- Structure de la table `surgrade`
CREATE TABLE IF NOT EXISTS `surgrade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `surgrade`
INSERT INTO `surgrade` (`id`, `libelle`) VALUES
(1, 'Officier'),
(2, 'Sous-officier'),
(3, 'Sapeur');

-- Structure de la table `grade`
CREATE TABLE IF NOT EXISTS `grade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(50) NOT NULL,
  `surgrade_id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`surgrade_id`) REFERENCES `surgrade` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `grade`
INSERT INTO `grade` (`id`, `libelle`, `surgrade_id`, `description`) VALUES
(1, 'Commandant', 1, 'Grade d officier supérieur'),
(2, 'Capitaine', 1, 'Grade d officier'),
(3, 'Sergent-chef', 2, 'Grade de sous-officier supérieur'),
(4, 'Sergent', 2, 'Grade de sous-officier'),
(5, 'Caporal', 3, 'Grade de sapeur');

-- Structure de la table `compte`
CREATE TABLE IF NOT EXISTS `compte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `compte`
INSERT INTO `compte` (`id`, `email`, `password`) VALUES
(1, 'admin@sdis.fr', 'admin'),
(2, 'user@sdis.fr', 'user');

-- Structure de la table `pompier`
DROP TABLE IF EXISTS `pompier`;
CREATE TABLE IF NOT EXISTS `pompier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numeroBip` varchar(10) DEFAULT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `caserne_id` int(11) DEFAULT NULL,
  `sexe` varchar(1) DEFAULT NULL,
  `telephone` varchar(15) DEFAULT NULL,
  `dateNaissance` date DEFAULT NULL,
  `grade_id` int(11) DEFAULT NULL,
  `compte_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pom_caserne` (`caserne_id`),
  KEY `fk_pom_grade` (`grade_id`),
  KEY `fk_pom_compte` (`compte_id`),
  CONSTRAINT `fk_pom_caserne` FOREIGN KEY (`caserne_id`) REFERENCES `caserne` (`id`),
  CONSTRAINT `fk_pom_grade` FOREIGN KEY (`grade_id`) REFERENCES `grade` (`id`),
  CONSTRAINT `fk_pom_compte` FOREIGN KEY (`compte_id`) REFERENCES `compte` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `pompier`
INSERT INTO `pompier` (`id`, `numeroBip`, `nom`, `prenom`, `caserne_id`, `sexe`, `telephone`, `dateNaissance`, `grade_id`, `compte_id`) VALUES
(1, 'BIP001', 'LEROY', 'Pierrick', 1, 'M', '0123456789', '1985-04-12', 1, 1),
(2, 'BIP002', 'MASSON', 'Bastien', 1, 'M', '0234567890', '1990-07-23', 2, NULL),
(3, 'BIP003', 'DUVAL', 'Matthias', 4, 'M', '0345678901', '1988-11-05', 3, NULL),
(4, 'BIP004', 'MADJI', 'Walid', 4, 'M', '0456789012', '1992-03-18', 4, NULL),
(6, 'BIP006', 'CHAUVEL', 'Jules', 1, 'M', '0567890123', '1995-09-30', 5, NULL),
(7, 'BIP007', 'CAUVIN', 'Nayah', 1, 'F', '0678901234', '1991-02-14', 4, NULL),
(8, 'BIP008', 'TRAORE', 'Sylvain', 3, 'M', '0789012345', '1987-06-21', 3, NULL),
(9, 'BIP009', 'BOULEAU', 'Line', 3, 'F', '0890123456', '1993-10-08', 5, NULL),
(10, 'BIP010', 'MANCEL', 'Florianne', 2, 'F', '0901234567', '1989-05-17', 2, 2),
(11, 'BIP011', 'PONTIER', 'Claire', 2, 'F', '0102345678', '1994-12-03', 4, NULL),
(12, 'BIP012', 'BARON', 'Gwladys', 3, 'F', '0213456789', '1986-08-25', 3, NULL),
(13, 'BIP013', 'PASTOR', 'Lucas', 1, 'M', '0324567890', '1997-01-19', 5, NULL),
(14, 'BIP014', 'BAREAU', 'Mila', 1, 'F', '0435678901', '1990-04-11', 4, NULL);

-- Structure de la table `fonction`
CREATE TABLE IF NOT EXISTS `fonction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `fonction`
INSERT INTO `fonction` (`id`, `libelle`, `description`) VALUES
(1, 'Secouriste', 'Spécialiste des premiers secours'),
(2, 'Conducteur', 'Habilité à conduire les véhicules d intervention'),
(3, 'Plongeur', 'Spécialiste des interventions aquatiques'),
(4, 'Formateur', 'Chargé de la formation des nouveaux pompiers');

-- Structure de la table `pompier_fonction`
CREATE TABLE IF NOT EXISTS `pompier_fonction` (
  `pompier_id` int(11) NOT NULL,
  `fonction_id` int(11) NOT NULL,
  PRIMARY KEY (`pompier_id`, `fonction_id`),
  KEY `fk_fonction` (`fonction_id`),
  CONSTRAINT `fk_pompier` FOREIGN KEY (`pompier_id`) REFERENCES `pompier` (`id`),
  CONSTRAINT `fk_fonction` FOREIGN KEY (`fonction_id`) REFERENCES `fonction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `pompier_fonction`
INSERT INTO `pompier_fonction` (`pompier_id`, `fonction_id`) VALUES
(1, 1), (1, 4), (2, 1), (2, 2), (3, 2), (4, 1), (6, 3), (7, 1), (8, 2), (9, 1), (10, 4);

-- Structure de la table `situation`
CREATE TABLE IF NOT EXISTS `situation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `situation`
INSERT INTO `situation` (`id`, `libelle`, `description`) VALUES
(1, 'Incendie', 'Intervention pour éteindre un feu'),
(2, 'Secours à personne', 'Intervention pour porter secours à une personne'),
(3, 'Accident de la route', 'Intervention suite à un accident de circulation'),
(4, 'Catastrophe naturelle', 'Intervention suite à une catastrophe naturelle');

-- Structure de la table `intervention`
CREATE TABLE IF NOT EXISTS `intervention` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lieu` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `heureAppel` varchar(5) NOT NULL,
  `heureArrivee` varchar(5) NOT NULL,
  `duree` varchar(5) NOT NULL,
  `situation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_situation` (`situation_id`),
  CONSTRAINT `fk_situation` FOREIGN KEY (`situation_id`) REFERENCES `situation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `intervention`
INSERT INTO `intervention` (`id`, `lieu`, `date`, `heureAppel`, `heureArrivee`, `duree`, `situation_id`) VALUES
(1, 'Rue des Lilas, Caen', '2024-03-15', '14:30', '14:45', '01:15', 1),
(2, 'Avenue du Général Leclerc, Ifs', '2024-03-16', '09:20', '09:35', '00:45', 2),
(3, 'Boulevard des Nations, Lisieux', '2024-03-17', '18:10', '18:25', '02:30', 3),
(4, 'Chemin du Moulin, Le Hom', '2024-03-18', '23:50', '00:10', '03:00', 4);

-- Structure de la table `pompier_intervention`
CREATE TABLE IF NOT EXISTS `pompier_intervention` (
  `pompier_id` int(11) NOT NULL,
  `intervention_id` int(11) NOT NULL,
  PRIMARY KEY (`pompier_id`, `intervention_id`),
  KEY `fk_intervention` (`intervention_id`),
  CONSTRAINT `fk_pompier_inter` FOREIGN KEY (`pompier_id`) REFERENCES `pompier` (`id`),
  CONSTRAINT `fk_intervention` FOREIGN KEY (`intervention_id`) REFERENCES `intervention` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `pompier_intervention`
INSERT INTO `pompier_intervention` (`pompier_id`, `intervention_id`) VALUES
(1, 1), (2, 1), (3, 1), (4, 2), (6, 2), (7, 3), (8, 3), (9, 3), (10, 4), (11, 4), (12, 4);

-- Structure de la table `type_vehicule`
CREATE TABLE IF NOT EXISTS `type_vehicule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `caracteristique` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `type_vehicule`
INSERT INTO `type_vehicule` (`id`, `nom`, `caracteristique`) VALUES
(1, 'VSAV', 'Véhicule de Secours et d Assistance aux Victimes'),
(2, 'FPT', 'Fourgon Pompe-Tonne'),
(3, 'EPA', 'Échelle Pivotante Automatique');

-- Structure de la table `vehicule`
CREATE TABLE IF NOT EXISTS `vehicule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `immat` varchar(10) NOT NULL,
  `dateOrigine` date NOT NULL,
  `dateRevision` date NOT NULL,
  `type_vehicule_id` int(11) NOT NULL,
  `caserne_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_type_vehicule` (`type_vehicule_id`),
  KEY `fk_veh_caserne` (`caserne_id`),
  CONSTRAINT `fk_type_vehicule` FOREIGN KEY (`type_vehicule_id`) REFERENCES `type_vehicule` (`id`),
  CONSTRAINT `fk_veh_caserne` FOREIGN KEY (`caserne_id`) REFERENCES `caserne` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `vehicule`
INSERT INTO `vehicule` (`id`, `immat`, `dateOrigine`, `dateRevision`, `type_vehicule_id`, `caserne_id`) VALUES
(1, 'AB-123-CD', '2020-01-15', '2024-01-15', 1, 1),
(2, 'EF-456-GH', '2019-05-20', '2023-05-20', 2, 2),
(3, 'IJ-789-KL', '2021-03-10', '2025-03-10', 3, 3),
(4, 'MN-012-OP', '2022-07-05', '2026-07-05', 1, 4);

-- Structure de la table `intervention_vehicule`
CREATE TABLE IF NOT EXISTS `intervention_vehicule` (
  `intervention_id` int(11) NOT NULL,
  `vehicule_id` int(11) NOT NULL,
  PRIMARY KEY (`intervention_id`, `vehicule_id`),
  KEY `fk_vehicule` (`vehicule_id`),
  CONSTRAINT `fk_inter_veh` FOREIGN KEY (`intervention_id`) REFERENCES `intervention` (`id`),
  CONSTRAINT `fk_vehicule` FOREIGN KEY (`vehicule_id`) REFERENCES `vehicule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Données pour la table `intervention_vehicule`
INSERT INTO `intervention_vehicule` (`intervention_id`, `vehicule_id`) VALUES
(1, 1), (1, 2), (2, 1), (3, 3), (4, 4);