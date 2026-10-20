-- ============================================================================
-- SCRIPT D'INITIALISATION DE LA BASE DE DONNÉES : "Le Panier Fermier"
-- Moteur : SQLite
-- ============================================================================

-- Activation du support des clés étrangères (spécifique à SQLite)
PRAGMA foreign_keys = ON;

-- Supprimer les tables si elles existent déjà (pour réinitialiser proprement)
DROP TABLE IF EXISTS ligne_commande;
DROP TABLE IF EXISTS commande;
DROP TABLE IF EXISTS produit;
DROP TABLE IF EXISTS producteur;
DROP TABLE IF EXISTS client;

-- ----------------------------------------------------------------------------
-- 1. CRÉATION DE LA STRUCTURE DES TABLES
-- ----------------------------------------------------------------------------

CREATE TABLE producteur (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nom TEXT NOT NULL,
    ville TEXT NOT NULL,
    specialite TEXT
);

CREATE TABLE produit (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nom TEXT NOT NULL,
    prix_unitaire REAL NOT NULL CHECK(prix_unitaire > 0),
    stock INTEGER NOT NULL CHECK(stock >= 0),
    producteur_id INTEGER,
    FOREIGN KEY (producteur_id) REFERENCES producteur(id) ON DELETE SET NULL
);

CREATE TABLE client (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nom TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    ville TEXT NOT NULL,
    date_inscription TEXT NOT NULL
);

CREATE TABLE commande (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER,
    date_commande TEXT NOT NULL,
    statut TEXT CHECK(statut IN ('En attente', 'Expédiée', 'Livrée', 'Annulée')),
    FOREIGN KEY (client_id) REFERENCES client(id) ON DELETE CASCADE
);

CREATE TABLE ligne_commande (
    commande_id INTEGER,
    produit_id INTEGER,
    quantite INTEGER NOT NULL CHECK(quantite > 0),
    PRIMARY KEY (commande_id, produit_id),
    FOREIGN KEY (commande_id) REFERENCES commande(id) ON DELETE CASCADE,
    FOREIGN KEY (produit_id) REFERENCES produit(id) ON DELETE RESTRICT
);

-- ----------------------------------------------------------------------------
-- 2. INSERTION DES DONNÉES DE TEST (SEEDING)
-- ----------------------------------------------------------------------------

-- A. Producteurs
INSERT INTO producteur (id, nom, ville, specialite) VALUES
(1, 'Ferme des Lilas', 'Villefranche', 'Maraîchage bio'),
(2, 'Le Verger du Soleil', 'Trévoux', 'Fruits et jus'),
(3, 'Maison Chèvre & Miel', 'Villefranche', 'Fromages et apiculture'),
(4, 'Domaine du Pain de Mie', 'Anse', 'Boulangerie artisanale'),
(5, 'Les Potagers du Val', 'Lyon', 'Légumes oubliés');

-- B. Produits
INSERT INTO produit (id, nom, prix_unitaire, stock, producteur_id) VALUES
(1, 'Pommes Gala (1kg)', 2.80, 50, 2),
(2, 'Miel de Lavarde (500g)', 8.50, 15, 3),
(3, 'Fromage de Chèvre Frais', 3.20, 25, 3),
(4, 'Jus de Pomme Bio (1L)', 3.50, 40, 2),
(5, 'Pain au Levain (500g)', 2.50, 30, 4),
(6, 'Carottes Bio (1kg)', 1.90, 80, 1),
(7, 'Courgettes (1kg)', 2.20, 60, 1),
(8, 'Tomates Anciennes (1kg)', 4.10, 35, 1),
(9, 'Panier Légumes Oubliés (3kg)', 12.00, 10, 5),
(10, 'Brioche Artisanale', 4.80, 0, 4); -- Produit en rupture de stock

-- C. Clients
INSERT INTO client (id, nom, email, ville, date_inscription) VALUES
(1, 'Alice Martin', 'alice.martin@email.fr', 'Lyon', '2024-11-15'),
(2, 'Bernard Dubois', 'b.dubois@email.fr', 'Villefranche', '2025-01-10'),
(3, 'Chantal Moreau', 'chantal.m@email.fr', 'Lyon', '2025-01-20'),
(4, 'David Bernard', 'david.b@email.fr', 'Trévoux', '2025-02-01'),
(5, 'Élodie Petit', 'elodie.petit@email.fr', 'Lyon', '2025-02-15'),
(6, 'François Leroy', 'f.leroy@email.fr', 'Caluire', '2025-03-01'); -- Client sans commande

-- D. Commandes
INSERT INTO commande (id, client_id, date_commande, statut) VALUES
(1, 1, '2025-02-10', 'Livrée'),
(2, 2, '2025-02-12', 'Livrée'),
(3, 3, '2025-02-18', 'Expédiée'),
(4, 1, '2025-02-22', 'Livrée'),
(5, 5, '2025-03-02', 'En attente'),
(6, 4, '2025-03-03', 'Annulée');

-- E. Lignes de commande
INSERT INTO ligne_commande (commande_id, produit_id, quantite) VALUES
-- Commande 1 (Alice)
(1, 1, 2), -- 2x Pommes
(1, 4, 1), -- 1x Jus de Pomme
(1, 5, 2), -- 2x Pain

-- Commande 2 (Bernard)
(2, 2, 1), -- 1x Miel
(2, 3, 3), -- 3x Fromage

-- Commande 3 (Chantal)
(3, 8, 2), -- 2x Tomates
(3, 6, 3), -- 3x Carottes

-- Commande 4 (Alice à nouveau)
(4, 9, 1), -- 1x Panier Légumes
(4, 2, 2), -- 2x Miel

-- Commande 5 (Élodie)
(5, 7, 2), -- 2x Courgettes
(5, 5, 1), -- 1x Pain

-- Commande 6 (David - Annulée)
(6, 1, 1);
