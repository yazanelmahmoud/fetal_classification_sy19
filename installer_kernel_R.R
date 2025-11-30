# Script simple pour installer le kernel R pour Jupyter
# Double-cliquez sur ce fichier ou ouvrez-le dans R et cliquez sur "Source"

cat("=== Installation du kernel R pour Jupyter ===\n\n")

# Étape 1 : Installer IRkernel
cat("Étape 1/2 : Installation du package IRkernel...\n")
install.packages("IRkernel", repos = "https://cran.rstudio.com/")

# Étape 2 : Installer le kernel dans Jupyter
cat("\nÉtape 2/2 : Installation du kernel dans Jupyter...\n")
IRkernel::installspec(user = TRUE)

cat("\n=== Installation terminée ! ===\n")
cat("Vous pouvez maintenant sélectionner le kernel R dans votre notebook Cursor/VS Code.\n")
cat("Si le kernel n'apparaît pas, fermez et rouvrez Cursor.\n")

