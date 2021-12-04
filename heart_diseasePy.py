# -*- coding: utf-8 -*-
"""
Created on Tue Apr 27 15:11:36 2021

@author: User
"""

import pandas as pd 
import numpy as np

heart_disease = pd.read_csv("F:/PCA/Assignment/Datasets_PCA/heart disease.csv")
heart_disease.describe()

from sklearn.decomposition import PCA
import matplotlib.pyplot as plt
from sklearn.preprocessing import scale 

normalized_heart_disease = scale(heart_disease)
normalized_heart_disease

pca_heart_disease = PCA(n_components = 13)
pca_vlaues = pca_heart_disease.fit_transform(normalized_heart_disease)

var = pca_heart_disease.explained_variance_ratio_
var

pca_heart_disease.components_
pca_heart_disease.components_[0]

var1 = np.cumsum(np.round(var, decimals =4) * 100)
var1

plt.plot(var1, color = "red")
pca_vlaues

pca_data = pd.DataFrame(pca_vlaues)
pca_data.columns ="comp0", "comp1", "comp2", "comp3", "comp4", "comp5","comp6", "comp7", "comp8", "comp9", "comp10", "comp11","comp12"  

final_heart_disease = pd.concat([heart_disease, pca_data.iloc[:, 0:3]], axis = 1)
final_heart_disease

import matplotlib.pylab as plt
plt.scatter(x = final_heart_disease.comp0, y = final_heart_disease.comp1)
plt.scatter(x = final_heart_disease.comp1, y = final_heart_disease.comp2)
plt.scatter(x = final_heart_disease.comp2, y = final_heart_disease.comp1)
