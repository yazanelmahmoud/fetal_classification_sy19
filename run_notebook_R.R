# Script R pour exécuter toutes les analyses du notebook
# Ce script peut être exécuté avec: Rscript run_notebook_R.R

# Chargement des bibliothèques nécessaires
cat("Chargement des bibliothèques...\n")
required_packages <- c("ggplot2", "dplyr", "corrplot", "gridExtra", "FactoMineR", 
                      "factoextra", "cluster", "class", "e1071", "MASS", "rpart", 
                      "randomForest", "caret", "pROC", "nnet", "mclust", "rpart.plot")

# Installation des packages manquants
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) {
  cat("Installation des packages manquants:", paste(new_packages, collapse=", "), "\n")
  install.packages(new_packages, repos = "https://cran.rstudio.com/")
}

# Chargement des packages
for(pkg in required_packages) {
  library(pkg, character.only = TRUE)
}

cat("Bibliothèques chargées avec succès!\n\n")

# Chargement du dataset
cat("Chargement du dataset...\n")
path <- "fetal_health.csv"
if(!file.exists(path)) {
  stop("Erreur: Le fichier 'fetal_health.csv' n'existe pas dans le répertoire courant.")
}
df <- read.csv(path)

# Nettoyage des noms de colonnes
names(df) <- gsub(" ", "_", names(df))
names(df) <- gsub("\\.", "_", names(df))

cat("Dataset chargé avec succès!\n")
cat("Dimensions:", nrow(df), "lignes,", ncol(df), "colonnes\n\n")

# Aperçu des données
cat("=== Aperçu des données ===\n")
print(head(df))
cat("\n=== Structure des données ===\n")
str(df)
cat("\n=== Statistiques descriptives ===\n")
print(summary(df))

# Répartition des classes
cat("\n=== Répartition des classes ===\n")
print(table(df$fetal_health))
cat("\nPourcentages par classe:\n")
print(prop.table(table(df$fetal_health)) * 100)

# Préparation des données pour les analyses
cat("\n=== Préparation des données ===\n")
features <- df[, -which(names(df) == "fetal_health")]
target <- df$fetal_health
features_scaled <- scale(features)
X_scaled_df <- as.data.frame(features_scaled)
X <- features_scaled
y <- factor(df$fetal_health)

# Division train/test
set.seed(42)
train_indices <- createDataPartition(y, p = 0.8, list = FALSE)
X_train <- X[train_indices, ]
X_test <- X[-train_indices, ]
y_train <- y[train_indices]
y_test <- y[-train_indices]
X_train_df <- as.data.frame(X_train)
X_test_df <- as.data.frame(X_test)

cat("Données préparées: Train =", nrow(X_train), "Test =", nrow(X_test), "\n\n")

# Matrice de corrélation
cat("=== Matrice de corrélation ===\n")
corr_matrix <- cor(df[, -which(names(df) == "fetal_health")])
cat("Matrice de corrélation calculée\n")

# PCA
cat("\n=== Analyse en Composantes Principales (PCA) ===\n")
pca_result <- prcomp(features_scaled, center = FALSE, scale. = FALSE)
cat("PCA effectuée. Variance expliquée par les 5 premières composantes:\n")
print(summary(pca_result)$importance[2, 1:5] * 100)

# Clustering K-Means
cat("\n=== Clustering K-Means ===\n")
set.seed(42)
kmeans_result <- kmeans(X_scaled_df, centers = 3, nstart = 25, iter.max = 100)
cat("Tableau croisé K-Means vs Santé Foetale:\n")
print(table(df$fetal_health, kmeans_result$cluster))
silhouette_kmeans <- silhouette(kmeans_result$cluster, dist(X_scaled_df))
cat("Score de Silhouette K-Means:", mean(silhouette_kmeans[, 3]), "\n")
ari_kmeans <- adjustedRandIndex(df$fetal_health, kmeans_result$cluster)
cat("Indice de Rand Ajusté K-Means:", ari_kmeans, "\n")

# Clustering hiérarchique
cat("\n=== Clustering Hiérarchique (CAH) ===\n")
dist_matrix <- dist(X_scaled_df)
hc_result <- hclust(dist_matrix, method = "ward.D2")
clusters_cah <- cutree(hc_result, k = 3)
cat("Tableau croisé CAH vs Santé Foetale:\n")
print(table(df$fetal_health, clusters_cah))
silhouette_cah <- silhouette(clusters_cah, dist_matrix)
cat("Score de Silhouette CAH:", mean(silhouette_cah[, 3]), "\n")
ari_cah <- adjustedRandIndex(df$fetal_health, clusters_cah)
cat("Indice de Rand Ajusté CAH:", ari_cah, "\n")

# KNN
cat("\n=== K-Nearest Neighbors (KNN) ===\n")
k_values <- 1:10
cv_scores <- numeric(length(k_values))
for (i in seq_along(k_values)) {
  knn_model <- knn(train = X_train, test = X_test, cl = y_train, k = k_values[i])
  cv_scores[i] <- mean(knn_model == y_test)
}
best_k <- k_values[which.max(cv_scores)]
cat("Meilleur k:", best_k, "avec accuracy:", max(cv_scores), "\n")
knn_pred <- knn(train = X_train, test = X_test, cl = y_train, k = best_k)
cat("Accuracy finale KNN:", mean(knn_pred == y_test), "\n")

# Naive Bayes
cat("\n=== Naive Bayes ===\n")
nb_model <- naiveBayes(x = X_train, y = y_train)
nb_pred <- predict(nb_model, newdata = X_test)
cat("Accuracy Naive Bayes:", mean(nb_pred == y_test), "\n")

# LDA
cat("\n=== Linear Discriminant Analysis (LDA) ===\n")
lda_model <- lda(x = X_train, grouping = y_train)
lda_pred <- predict(lda_model, newdata = X_test)
cat("Accuracy LDA:", mean(lda_pred$class == y_test), "\n")

# QDA
cat("\n=== Quadratic Discriminant Analysis (QDA) ===\n")
qda_model <- qda(x = X_train, grouping = y_train)
qda_pred <- predict(qda_model, newdata = X_test)
cat("Accuracy QDA:", mean(qda_pred$class == y_test), "\n")

# Régression Logistique
cat("\n=== Régression Logistique Multinomiale ===\n")
logreg_model <- multinom(y_train ~ ., data = X_train_df, maxit = 1000)
logreg_pred <- predict(logreg_model, newdata = X_test_df)
cat("Accuracy Logistic Regression:", mean(logreg_pred == y_test), "\n")

# Decision Tree
cat("\n=== Decision Tree ===\n")
dt_model <- rpart(y_train ~ ., data = X_train_df, method = "class")
dt_pred <- predict(dt_model, newdata = X_test_df, type = "class")
cat("Accuracy Decision Tree:", mean(dt_pred == y_test), "\n")

# Random Forest
cat("\n=== Random Forest ===\n")
rf_model <- randomForest(x = X_train, y = y_train, ntree = 100, importance = TRUE)
rf_pred <- predict(rf_model, newdata = X_test)
cat("Accuracy Random Forest:", mean(rf_pred == y_test), "\n")

# Comparaison finale
cat("\n=== Comparaison de tous les modèles ===\n")
results <- data.frame(
  Model = c("KNN", "Naive Bayes", "LDA", "QDA", "Logistic Regression", 
            "Decision Tree", "Random Forest"),
  Accuracy = c(
    mean(knn_pred == y_test),
    mean(nb_pred == y_test),
    mean(lda_pred$class == y_test),
    mean(qda_pred$class == y_test),
    mean(logreg_pred == y_test),
    mean(dt_pred == y_test),
    mean(rf_pred == y_test)
  )
)
results <- results[order(results$Accuracy, decreasing = TRUE), ]
print(results)

cat("\n=== Analyse terminée avec succès! ===\n")

