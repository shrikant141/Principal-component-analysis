# -*- coding: utf-8 -*-
"""
Created on Tue Apr 27 14:26:36 2021

@author: User
"""

import pandas as pd 
import numpy as np


wine = pd.read_csv("F:/PCA/Assignment/Datasets_PCA/wine.csv")
wine.describe()

from sklearn.decomposition import PCA
import matplotlib.pyplot as plt
from sklearn.preprocessing import scale 

normalized_wine = scale(wine)
normalized_wine


pca_wine = PCA(n_components = 13)
pca_vlaues = pca_wine.fit_transform(normalized_wine)

var = pca_wine.explained_variance_ratio_
var
pca_wine.components_
pca_wine.components_
pca_wine.components_[0]

var1 = np.cumsum(np.round(var, decimals =4) * 100)
var1

plt.plot(var1, color = "red")
pca_vlaues


pca_data = pd.DataFrame(pca_vlaues)
pca_data.columns ="comp0", "comp1", "comp2", "comp3", "comp4", "comp5","comp6", "comp7", "comp8", "comp9", "comp10", "comp11","comp12"  



final_wine = pd.concat([wine, pca_data.iloc[:, 0:3]], axis = 1)
final_wine

import matplotlib.pylab as plt
plt.scatter(x = final_wine.comp0, y = final_wine.comp1)
plt.scatter(x = final_wine.comp1, y = final_wine.comp2)
plt.scatter(x = final_wine.comp2, y = final_wine.comp1)
