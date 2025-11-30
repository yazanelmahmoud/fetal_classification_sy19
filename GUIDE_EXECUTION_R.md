# Guide d'exécution du notebook R

## Option 1 : Exécuter avec Jupyter Notebook/Lab (Recommandé)

### Installation nécessaire :

1. **Installer R** :
   - Télécharger depuis : https://cran.r-project.org/
   - Installer R pour Windows
   - Ajouter R au PATH système

2. **Installer Jupyter avec kernel R** :
   ```powershell
   # Dans PowerShell (en tant qu'administrateur)
   R
   # Dans la console R :
   install.packages(c("IRkernel", "devtools"))
   devtools::install_github("IRkernel/IRkernel")
   IRkernel::installspec()
   ```

3. **Installer les packages R nécessaires** :
   ```r
   install.packages(c("ggplot2", "dplyr", "corrplot", "gridExtra", 
                      "FactoMineR", "factoextra", "cluster", "class", 
                      "e1071", "MASS", "rpart", "randomForest", 
                      "caret", "pROC", "nnet", "mclust", "rpart.plot"))
   ```

4. **Lancer Jupyter** :
   ```powershell
   jupyter notebook
   ```
   Ou avec JupyterLab :
   ```powershell
   jupyter lab
   ```

5. **Ouvrir le notebook** : `projet_sy19_R.ipynb`

## Option 2 : Exécuter avec RStudio

1. **Installer RStudio** : https://www.rstudio.com/products/rstudio/download/

2. **Ouvrir RStudio** et installer les packages :
   ```r
   install.packages(c("ggplot2", "dplyr", "corrplot", "gridExtra", 
                      "FactoMineR", "factoextra", "cluster", "class", 
                      "e1071", "MASS", "rpart", "randomForest", 
                      "caret", "pROC", "nnet", "mclust", "rpart.plot"))
   ```

3. **Ouvrir le notebook** dans RStudio (fichier .ipynb)

## Option 3 : Exécuter le script R directement

Si vous avez R installé, vous pouvez exécuter le script `run_notebook_R.R` :

```powershell
Rscript run_notebook_R.R
```

Ou dans RStudio :
- Ouvrir `run_notebook_R.R`
- Cliquer sur "Source" ou appuyer sur Ctrl+Shift+S

## Option 4 : Utiliser VS Code / Cursor avec extension R

1. **Installer l'extension R** dans VS Code/Cursor
2. **Installer R** (voir Option 1)
3. **Ouvrir le notebook** dans VS Code/Cursor
4. **Sélectionner le kernel R** dans le notebook

## Vérification de l'installation

Pour vérifier si R est installé :
```powershell
R --version
```

Pour vérifier les packages installés :
```r
installed.packages()
```

## Notes importantes

- Assurez-vous que le fichier `fetal_health.csv` est dans le même répertoire que le notebook
- Certaines analyses peuvent prendre du temps (Random Forest, PCA, etc.)
- Les graphiques seront affichés dans le notebook ou dans une fenêtre séparée selon votre configuration

