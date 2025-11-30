# Résolution des erreurs d'exécution du notebook R

## Problème 1 : Erreur de kernel non approuvé

Si vous voyez cette erreur :
```
The kernel 'R' was not started as it is located in an insecure location
```

### Solution rapide :

1. **Dans Cursor/VS Code**, ouvrez les paramètres :
   - Appuyez sur `Ctrl + ,` (virgule)
   - Ou allez dans File > Preferences > Settings

2. **Cherchez** : `jupyter.kernels.trusted`

3. **Ajoutez le chemin du kernel R** dans la liste des kernels approuvés :
   - Cliquez sur "Edit in settings.json"
   - Ajoutez cette ligne :
   ```json
   "jupyter.kernels.trusted": [
       "c:\\ProgramData\\jupyter\\kernels\\ir\\kernel.json"
   ]
   ```
   - Ou pour approuver tous les kernels dans ce dossier :
   ```json
   "jupyter.kernels.trusted": [
       "c:\\ProgramData\\jupyter\\kernels\\**"
   ]
   ```

4. **Redémarrez Cursor** complètement

5. **Réessayez d'exécuter** la première cellule

---

## Problème 2 : Erreur d'installation de ggplot2 (non-zero exit status)

Si vous voyez cette erreur :
```
Warning message: "installation of package 'ggplot2' had non-zero exit status"
Warning message: "dependency 'Hmisc' is not available"
```

### Solution rapide :

1. **Ouvrez R ou RStudio**

2. **Exécutez le script spécialisé** :
   ```r
   source("installer_ggplot2_manuel.R")
   ```

3. **Ou installez manuellement** :
   ```r
   # Installer d'abord Hmisc (dépendance manquante)
   install.packages("Hmisc", repos = "https://cran.rstudio.com/", type = "binary")
   
   # Installer ggplot2 depuis les binaires (pas depuis les sources)
   install.packages("ggplot2", repos = "https://cran.rstudio.com/", type = "binary")
   ```

4. **Si cela ne fonctionne toujours pas**, installez une version stable :
   ```r
   # Installer devtools si nécessaire
   if (!requireNamespace("devtools", quietly = TRUE)) {
     install.packages("devtools", repos = "https://cran.rstudio.com/", type = "binary")
   }
   
   # Installer ggplot2 version 3.4.2 (version binaire stable)
   devtools::install_version("ggplot2", version = "3.4.2", 
                             repos = "https://cran.rstudio.com/",
                             type = "binary")
   ```

5. **Vérifiez l'installation** :
   ```r
   library(ggplot2)
   cat("✓ ggplot2 installé avec succès!\n")
   ```

---

## Problème 3 : Erreur de bibliothèques manquantes (général)

Si vous voyez des erreurs comme :
```
Error in library(ggplot2) : there is no package called 'ggplot2'
```

### Solution : Installer toutes les bibliothèques

#### Option A : Dans R ou RStudio (Recommandé)

1. **Ouvrez R** (ou RStudio)
   - Cherchez "R x64" dans le menu Démarrer Windows

2. **Exécutez le script d'installation** :
   ```r
   source("installer_packages_R.R")
   ```
   
   Ou copiez-collez directement dans la console R :
   ```r
   # Liste des packages nécessaires
   packages <- c("ggplot2", "dplyr", "corrplot", "gridExtra", 
                "FactoMineR", "factoextra", "cluster", "class", 
                "e1071", "MASS", "rpart", "randomForest", 
                "caret", "pROC", "nnet", "mclust", "rpart.plot")
   
   # Installation
   install.packages(packages, repos = "https://cran.rstudio.com/")
   ```

3. **Attendez** que l'installation se termine (peut prendre 5-10 minutes)

4. **Vérifiez** que tout est installé :
   ```r
   all(sapply(packages, requireNamespace, quietly = TRUE))
   ```
   Devrait retourner `TRUE`

#### Option B : Directement dans le notebook (si le kernel fonctionne)

1. **Créez une nouvelle cellule** au début du notebook
2. **Exécutez** ce code :
   ```r
   # Installation automatique des packages manquants
   required_packages <- c("ggplot2", "dplyr", "corrplot", "gridExtra", 
                          "FactoMineR", "factoextra", "cluster", "class", 
                          "e1071", "MASS", "rpart", "randomForest", 
                          "caret", "pROC", "nnet", "mclust", "rpart.plot")
   
   new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
   if(length(new_packages) > 0) {
     install.packages(new_packages, repos = "https://cran.rstudio.com/")
   }
   ```

---

## Vérification complète

Pour vérifier que tout fonctionne :

1. **Vérifiez que R est installé** :
   - Ouvrez PowerShell
   - Tapez : `R --version`
   - (Si ça ne marche pas, R n'est pas dans le PATH, mais ce n'est pas grave si vous utilisez RStudio)

2. **Vérifiez que le kernel R est installé** :
   - Dans R, exécutez :
   ```r
   IRkernel::installspec(user = TRUE)
   ```

3. **Testez dans le notebook** :
   - Exécutez cette cellule de test :
   ```r
   library(ggplot2)
   cat("✓ ggplot2 chargé avec succès!\n")
   ```

---

## Ordre recommandé pour résoudre les problèmes

1. ✅ **D'abord** : Résoudre le problème de kernel non approuvé (Problème 1)
2. ✅ **Ensuite** : Si ggplot2 échoue, utiliser `installer_ggplot2_manuel.R` (Problème 2)
3. ✅ **Puis** : Installer les autres bibliothèques (Problème 3, Option A)
4. ✅ **Enfin** : Exécuter le notebook cellule par cellule

---

## Si rien ne fonctionne

Essayez d'utiliser **RStudio** à la place :
1. Installez RStudio : https://www.rstudio.com/products/rstudio/download/
2. Ouvrez RStudio
3. Installez les packages (voir Option A ci-dessus)
4. Ouvrez le fichier `projet_sy19_R.ipynb` dans RStudio
5. Exécutez les cellules

---

## Fichiers utiles dans ce projet

- `installer_packages_R.R` : Script pour installer tous les packages
- `installer_ggplot2_manuel.R` : Script spécialisé pour installer ggplot2 si l'installation automatique échoue
- `run_notebook_R.R` : Script alternatif pour exécuter toutes les analyses sans notebook
- `installer_kernel_R.R` : Script pour installer le kernel R pour Jupyter

