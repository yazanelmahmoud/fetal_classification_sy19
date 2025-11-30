# Guide simple : Installer le Kernel R pour Jupyter

## Étape 1 : Vérifier que R est installé

1. Ouvrez **R** (l'application R que vous avez installée)
   - Cherchez "R x64 4.x.x" dans le menu Démarrer

2. Vérifiez que ça fonctionne - vous devriez voir une console R s'ouvrir

## Étape 2 : Installer le kernel R dans R

Dans la console R qui s'est ouverte, copiez-collez ces lignes **une par une** et appuyez sur Entrée :

```r
# 1. Installer IRkernel (le kernel R pour Jupyter)
install.packages("IRkernel")

# 2. Installer le kernel dans Jupyter (dans votre répertoire utilisateur)
IRkernel::installspec(user = TRUE)
```

**Important :** 
- Attendez que chaque commande se termine avant de passer à la suivante
- Si on vous demande de choisir un miroir CRAN, choisissez n'importe lequel (par exemple "France")
- Cela peut prendre quelques minutes

## Étape 3 : Vérifier l'installation

Après avoir exécuté les commandes, vous devriez voir un message de confirmation.

## Étape 4 : Utiliser le kernel dans Cursor

1. Ouvrez votre notebook `projet_sy19_R.ipynb` dans Cursor
2. En haut à droite du notebook, cliquez sur **"Select Kernel"** (ou "Choisir un kernel")
3. Vous devriez voir **"R"** ou **"ir"** dans la liste
4. Sélectionnez-le

## Si ça ne marche pas

Si le kernel n'apparaît pas :
1. Fermez complètement Cursor
2. Rouvrez Cursor
3. Rouvrez le notebook
4. Réessayez de sélectionner le kernel

---

**C'est tout !** C'est exactement comme installer Python et son kernel, mais avec R.

