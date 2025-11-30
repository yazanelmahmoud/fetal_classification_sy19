# Script pour installer toutes les bibliothèques nécessaires pour le projet
# Exécutez ce script dans R ou RStudio avant d'exécuter le notebook

cat("=== Installation des packages R nécessaires ===\n\n")

# Liste de tous les packages nécessaires
required_packages <- c(
  "ggplot2",      # Visualisation
  "dplyr",        # Manipulation de données
  "corrplot",     # Matrices de corrélation
  "gridExtra",    # Arrangement de graphiques
  "FactoMineR",   # Analyse factorielle
  "factoextra",   # Visualisation ACP
  "cluster",      # Clustering
  "class",        # KNN
  "e1071",        # Naive Bayes, SVM
  "MASS",         # LDA, QDA
  "rpart",        # Arbres de décision
  "randomForest", # Random Forest
  "caret",        # Classification et régression
  "pROC",         # Courbes ROC
  "nnet",         # Réseaux de neurones (multinom)
  "mclust",       # Clustering gaussien
  "rpart.plot"    # Visualisation d'arbres
)

cat("Vérification des packages installés...\n")
installed_packages <- installed.packages()[,"Package"]
missing_packages <- required_packages[!(required_packages %in% installed_packages)]

if(length(missing_packages) > 0) {
  cat("\nPackages manquants à installer:\n")
  cat(paste(missing_packages, collapse=", "), "\n\n")
  
  cat("Installation en cours...\n")
  cat("(Cela peut prendre plusieurs minutes)\n\n")
  
  # Installation des packages manquants
  for(pkg in missing_packages) {
    cat("Installation de", pkg, "...\n")
    tryCatch({
      install.packages(pkg, repos = "https://cran.rstudio.com/", dependencies = TRUE)
      cat("✓", pkg, "installé avec succès\n")
    }, error = function(e) {
      cat("✗ Erreur lors de l'installation de", pkg, ":", e$message, "\n")
    })
  }
} else {
  cat("\n✓ Tous les packages sont déjà installés!\n")
}

# Vérification finale
cat("\n=== Vérification finale ===\n")
all_installed <- TRUE
for(pkg in required_packages) {
  if(requireNamespace(pkg, quietly = TRUE)) {
    cat("✓", pkg, "\n")
  } else {
    cat("✗", pkg, "- ERREUR: Package non disponible\n")
    all_installed <- FALSE
  }
}

if(all_installed) {
  cat("\n=== SUCCÈS: Tous les packages sont installés et disponibles! ===\n")
  cat("Vous pouvez maintenant exécuter le notebook projet_sy19_R.ipynb\n")
} else {
  cat("\n=== ATTENTION: Certains packages n'ont pas pu être installés ===\n")
  cat("Vérifiez votre connexion Internet et réessayez.\n")
  cat("Vous pouvez aussi installer manuellement les packages manquants avec:\n")
  cat("install.packages('nom_du_package')\n")
}

