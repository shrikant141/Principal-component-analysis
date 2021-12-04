install.packages("readr")
library(readr)
install.packages("readxl")
library(readxl)
wine <- read.csv(file.choose())
View(wine)
wine1 <- wine[,-1]
attach(wine1)
pca_wine <- princomp(wine1, cor = TRUE, scores = TRUE, covmat = NULL)
str(pca_wine)
summary(pca_wine)
loadings(pca_wine)
plot(pca_wine)
biplot(pca_wine)
plot(cumsum(pca_wine$sdev * pca_wine$sdev) * 100 / (sum(pca_wine$sdev * pca_wine$sdev)), type = "b")
pca_wine$scores
pca_wine$scores[,1:3]
final_wine <- cbind(wine[,-1],pca_wine$scores[,1:3])
View(final_wine)
# Scatter diagram
plot(final_wine$Comp.1, final_wine$Comp.2)
plot(final_wine$Comp.2,final_wine$Comp.3)
plot(final_wine$Comp.1,final_wine$Comp.3)

###### Clustering 
######## Heirarchical clustering

install.packages("readr")
library(readr)
install.packages("cluster")
library(cluster)
install.packages("factoextra")
library(factoextra)

winedata <- read.csv(file.choose())
View(winedata)
view(winedata[,-1])
winedata1 <- winedata[, -1]
attach(winedata)
cor(winedata1)
?princomp
pcaObj <- princomp(winedata1, cor = TRUE, scores = TRUE, covmat = NULL )
str((pcaObj))
summary(pcaObj)
str(pcaObj)
loadings(pcaObj)
plot(pcaObj)
biplot(pcaObj)
plot(cumsum(pcaObj$sdev)*100/(sum(pcaObj$sdev)), type = "b")
pcaObj$scores[,1:3]
winedata <- cbind(winedata, pcaObj$scores[,1:3])
View(winedata)
clus_wine <- winedata[,8:10]
norm_wine <- scale(clus_wine)
dist1 <- dist(norm_wine, method = "euclidean")
fit1 <- hclust(dist1, method = "complete")
plot(fit1)
rect.hclust(fit1, k= 3, border = "red")
groups <- cutree(fit1, 3)
membership1 <- as.matrix(groups)
View(membership1)
final1 <- cbind(membership1, winedata)
View(final1)
View(aggregate(final1[,-c(2,16:18)], by = list(membership1), FUN = mean))
write.csv(final1,file="wine_cluster.csv",row.names = F,col.names = F)
getwd()

###############################
####### K-Means
##############################

install.packages("plyr")
library(plyr)
wine_data <- read.csv(file.choose())
str(wine_data)
View(wine_data)
normalized_wine<-scale(wine_data[,2:14])
wss = (nrow(normalized_wine)-1)*sum(apply(normalized_wine, 2, var))
for (i in 1:7) wss[i] = sum(kmeans(normalized_wine, centers=i)$withinss)
plot(1:7, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")
title(sub = "K-Means Clustering Scree-Plot")
fit <- eclust(normalized_wine, "kmeans", k = 3, nstart = 25, graph = FALSE) # 7 cluster solution
fviz_cluster(fit, geom = "point", frame.type = "norm")

final2<- data.frame(fit$cluster,wine_data) # append cluster membership
View(final2)
aggregate(wine_data[,2:14], by=list(fit$cluster), FUN=mean)
table(fit$cluster)

