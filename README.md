Problem Statement: Using partial least squares regression for generalized linear models (the plsRglm package in R) using caret package, build an ensemble model to predict the quality score given to each wine from the Vinho Verde region of Portugal.

Project Objective: Predict the quality of Wine

Data:  https://archive.ics.uci.edu/ml/datasets/Wine+Quality

The data consists of 11 features which are: fixed acidity, volatile acidity, citric acid, residual sugar, chlorides, free sulfur dioxide, total sulfur dioxide, density, pH, sulphates, alcohol; and 1 output variable which is quality of wine. There are two data sets for red and white wine types. Data sets will be concatenated, and general model is going to be trained for both red and white wine types.

Programming Language:  R

Let’s get started….

Step-1:  Installation of all required packages and libraries

In this Project, I am using Caret package. The caret package (short for Classification and Regression Training) contains functions to streamline the model training process for complex regression and classification problems.


Step-2:  Importing or Loading the data

I have used rbind function to concatenate the dataset.


Step-3:  Exploratory Data Analysis and Data Preprocessing
In statistics, exploratory data analysis is an approach to analyzing data sets to summarize their main characteristics, often with visual methods.


a)	Understand the data: 
By getting structure and summary of data is the way to understand the data.

b)	Missing Values: 
Checking missing values if any using is.na function in R. There are no missing values in dataset which is good for our model performance.

c)	Exploring the attributes:
Below plots show the quality of wine and level of alcohol based on wine color

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/1)
![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/2)

Below plots show the density, level of volatile acidity, chlorides, and density of wine based on color.

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/3)
![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/4)
![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/5)

In the below plot we can say that there are same amount of red and white wines with quality '3', '4' and '9', more red wines with quality '5' and more white wines with quality "6", "7" and "8".

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/6)


d)	Finding Correlation between the attributes with quality:

Finding correlation is an important task in machine learning projects as we need to know about the correlation between each attribute with outcome attribute.

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/7)
![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/8)























