import sqlite3

#  Connexion à la base de données 
connexion = sqlite3.connect('panier_fermier.db')
curseur = connexion.cursor()

#Partie 1 : Les bases - Extraction et Filtrage

print("1) Liste des producteurs : Affichez tous les producteurs, triés par ordre alphabétique de leur nom")
requete = "SELECT * FROM producteur ORDER BY nom ASC;"
curseur.execute(requete)

# Récupérer et afficher les résultats
resultats = curseur.fetchall()
for ligne in resultats:
    print(ligne)

print("\n2) Recherche ciblée : Affichez les produits dont le prix unitaire est inférieur à 5,00 euros.")
requete = "SELECT * FROM produit WHERE prix_unitaire < 5.00;"
curseur.execute(requete)

resultats = curseur.fetchall()
for ligne in resultats:
    print(ligne)

print("\n3) Filtres multiples : Trouvez tous les clients habitant à \"Lyon\" et inscrits après le 1er janvier 2025.")
requete = "SELECT * FROM client WHERE ville = 'Lyon' AND date_inscription > '2025-01-01';"
curseur.execute(requete)

resultats = curseur.fetchall()
for ligne in resultats:
    print(ligne)

print("\n4) Limitation : Affichez les 5 produits les plus chers du catalogue.")
requete = "SELECT * FROM produit ORDER BY prix_unitaire DESC LIMIT 5;"
curseur.execute(requete)

resultats = curseur.fetchall()
for ligne in resultats:
    print(ligne)

#Partie 2 : Fonctions d'agrégation et Regroupement

print("\n1) Comptage simple : Combien y a-t-il de clients inscrits au total ?")
requete = "SELECT COUNT(*) AS nombre_clients FROM client;"
curseur.execute(requete)

resultats = curseur.fetchall()
for ligne in resultats:
    print(ligne)

print("\n2) Moyennes et Totaux : Quel est le prix moyen des produits proposés par la coopérative ? Quel est le stock total disponible ?")
requete = "SELECT AVG(prix_unitaire) AS prix_moyen, SUM(stock) AS stock_total FROM produit;"
curseur.execute(requete)

resultats = curseur.fetchall()
for ligne in resultats:
    print(ligne)

print("\n3) Agrégation par producteur : Affichez l'identifiant de chaque producteur ainsi que le nombre de produits différents qu'il propose.")
requete = "SELECT producteur_id, COUNT(*) AS nombre_produits FROM produit GROUP BY producteur_id;"
curseur.execute(requete)

resultats = curseur.fetchall()
for ligne in resultats:
    print(ligne)

print("\n4) Filtrage sur agrégat (HAVING) : Quels sont les producteurs qui proposent plus de 3 produits ?")
requete = """
SELECT producteur.nom, COUNT(produit.id) AS nombre_produits 
FROM producteur 
JOIN produit ON producteur.id = produit.producteur_id 
GROUP BY producteur.id 
HAVING COUNT(produit.id) > 3;
"""
curseur.execute(requete)

resultats = curseur.fetchall()
for ligne in resultats:
    print(f"Producteur: {ligne[0]}, Nombre de produits: {ligne[1]}")
else:
    print("Aucun producteur ne propose plus de 3 produits.")

print("\n5) Chiffre d'affaires potentiel : Calculez la valeur totale du stock (quantité en stock multipliée par le prix unitaire) pour chaque produit.")
requete = "SELECT nom, (stock * prix_unitaire) AS valeur_stock FROM produit;"
curseur.execute(requete)

resultats = curseur.fetchall()
for ligne in resultats: 
    print(f"Produit: {ligne[0]} , Valeur du stock: {ligne[1]}")

connexion.close()