install.packages("readr")
library(readr)
install.packages("readxl")
library(readxl)

heart_disease <- read.csv(file.choose())

View(heart_disease)
attach(heart_disease)

pca_heart_disease <- princomp(heart_disease, cor = TRUE, scores = TRUE, covmat = NULL)

str(pca_heart_disease)

summary(pca_heart_disease)

loadings(pca_heart_disease)

plot(pca_heart_disease)

biplot(pca_heart_disease)

plot(cumsum(pca_heart_disease$sdev * pca_heart_disease$sdev) * 100 / (sum(pca_heart_disease$sdev * pca_heart_disease$sdev)), type = "b")

pca_heart_disease$scores

pca_heart_disease$scores[,1:3]

final_heart_disease <- cbind(heart_disease,pca_heart_disease$scores[,1:3])

View(final_heart_disease)

# Scatter diagram
plot(final_heart_disease$Comp.1, final_heart_disease$Comp.2)

plot(final_heart_disease$Comp.2,final_heart_disease$Comp.3)

plot(final_heart_disease$Comp.1,final_heart_disease$Comp.3)
