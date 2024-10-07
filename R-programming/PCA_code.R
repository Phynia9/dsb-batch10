library(readr)
library(tidyverse)

library(FactoMineR) # PCA function
library(factoextra)
source("http://blogs.5eanalytics.com/RCode/PCA_functions.R")

df_concrete <- read_csv("C:/Users/Phani/OneDrive/Desktop/Master/Hofstra/5th fall_2024/IT270_Data_Mining/Homework/datasets_Concrete_Data.csv")
View(df_concrete)

summary(df_concrete)

# change type of data
df_concrete$Superplasticizer <- as.numeric(df_concrete$Superplasticizer)
nrow(df_concrete)
pca_result <- PCA(df_concrete, scale.unit = T, graph = T)
summary(pca_result)
fviz_screeplot(pca_result, ncp=10)

# communalities
communality(pca_result)
display_pc(pca_result)
pca_result$var


#Rotation 
pca_result$eig # will get eigenvalue
pca_result$var #  we run to see coord
# coord => loadings สัมประสิท
pca_result$var$coord

#varimax Rotation and place back 
loadings.pcarot = varimax(pca_result$var$coord)$loadings # need to get only coord to find varimax.
# varimax will give shole things but we need loadings as we select loadings at the back
pca_result$var$coord = loadings.pcarot
plot(pca_result, choix  ="var") # the result reduces
display_pc(pca_result, cutoff = 0.5) 

#compute 
as.matrix(df_concrete) %*% as.matrix(pca_result$var$coord[,1:5])

summary(pca_result)
pca_result$var$contrib
