# Script pour installer ggplot2 et ses dépendances manuellement
# Exécutez ce script dans R ou RStudio si l'installation automatique échoue

cat("=== Installation manuelle de ggplot2 et dépendances ===\n\n")

# Méthode 1 : Installer depuis les binaires (recommandé sur Windows)
cat("Méthode 1 : Installation depuis les binaires...\n")
tryCatch({
  # Installer d'abord les dépendances de base
  cat("Installation des dépendances de base...\n")
  install.packages(c("Hmisc", "yaml", "systemfonts", "svglite"), 
                   repos = "https://cran.rstudio.com/", 
                   type = "binary")
  
  # Installer ggplot2 depuis les binaires
  cat("Installation de ggplot2...\n")
  install.packages("ggplot2", repos = "https://cran.rstudio.com/", 
                   type = "binary", dependencies = FALSE)
  
  # Vérifier l'installation
  if(requireNamespace("ggplot2", quietly = TRUE)) {
    cat("✓ ggplot2 installé avec succès!\n")
  } else {
    stop("ggplot2 n'a pas pu être chargé")
  }
}, error = function(e) {
  cat("✗ Échec de la méthode 1:", e$message, "\n\n")
  
  # Méthode 2 : Installer une version plus ancienne (stable)
  cat("Méthode 2 : Installation d'une version stable de ggplot2...\n")
  tryCatch({
    # Installer une version spécifique qui fonctionne bien
    if (!requireNamespace("devtools", quietly = TRUE)) {
      install.packages("devtools", repos = "https://cran.rstudio.com/", type = "binary")
    }
    
    # Installer ggplot2 version 3.4.2 (version binaire disponible)
    devtools::install_version("ggplot2", version = "3.4.2", 
                              repos = "https://cran.rstudio.com/",
                              type = "binary")
    
    if(requireNamespace("ggplot2", quietly = TRUE)) {
      cat("✓ ggplot2 version 3.4.2 installé avec succès!\n")
    }
  }, error = function(e2) {
    cat("✗ Échec de la méthode 2:", e2$message, "\n\n")
    
    # Méthode 3 : Instructions manuelles
    cat("=== Instructions manuelles ===\n")
    cat("Si les méthodes automatiques échouent, suivez ces étapes:\n\n")
    cat("1. Ouvrez R ou RStudio\n")
    cat("2. Exécutez ces commandes une par une:\n\n")
    cat("   install.packages('Hmisc', repos='https://cran.rstudio.com/', type='binary')\n")
    cat("   install.packages('ggplot2', repos='https://cran.rstudio.com/', type='binary')\n\n")
    cat("3. Si cela ne fonctionne toujours pas, installez Rtools:\n")
    cat("   - Téléchargez depuis: https://cran.r-project.org/bin/windows/Rtools/\n")
    cat("   - Installez Rtools\n")
    cat("   - Redémarrez R\n")
    cat("   - Réessayez l'installation\n")
  })
})

# Vérification finale
cat("\n=== Vérification finale ===\n")
if(requireNamespace("ggplot2", quietly = TRUE)) {
  cat("✓ ggplot2 est installé et peut être chargé\n")
  cat("Version installée:", as.character(packageVersion("ggplot2")), "\n")
} else {
  cat("✗ ggplot2 n'est toujours pas installé\n")
  cat("Veuillez suivre les instructions manuelles ci-dessus\n")
}



