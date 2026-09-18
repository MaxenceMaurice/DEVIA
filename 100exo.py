#1 vérifie si un nombre donné est supérieur à 10
nombre = float(input("Entrez un nombre : "))

if nombre > 10:
    print("Le nombre est supérieur à 10.")
else:
    print("Le nombre n'est pas supérieur à 10.")


#2. Vérifier si un nombre donné est positif, négatif ou nul.

nombre = float(input("Entrez un nombre : "))

if nombre > 0:
    print("Le nombre est positif.")
elif nombre < 0:
    print("Le nombre est négatif.")
else:
    print("Le nombre est nul.")

#3. affiche "Vous êtes mineur" si l’âge est inférieur à 18

age = int(input("Entrez votre âge : "))

if age < 18:
    print("Vous êtes mineur.")
else:
    print("Vous êtes majeur.")