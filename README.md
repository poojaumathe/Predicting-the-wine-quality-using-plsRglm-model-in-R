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

So, the above correlation graphs show the correlation between all attributes where we can see alcohol is more correlated to the quality of wine. First correlation graph is without melting(reshaping) the values and other has reshaped values.

The below graphs show the density vs alcohol correlation by wine color and quality.

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/9)
![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/10)

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/11)

As we can observe from the graphs that Wine with high alcohol percentage has quality level 7, wine with less alcohol percentage is quality level 5.


e)	Frequency distribution: 
The height of each bar shows how many falls into each range. Plotting histogram using hist() function , we can visualize the frequency distribution of each attribute.   

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/12)
![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/13)
![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/14)

f)	Outliers:

Outlier is a data point that differs significantly from other observations.
Let’s check the outliers in our data…

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/15)

There are so many outliers in each variable which is not good for the model performance. We need to remove them.


g)	Skewness: 

In probability theory and statistics, skewness is a measure of the asymmetry of the probability distribution of a real-valued random variable about its mean. The skewness value can be positive or negative, or undefined.


h)	Data Transformation / Preparation:

From the above results as we know that our data is bit skewed and there are outliers so here, we are using Box cox transformation method to transform the data.


Creating a function to remove outliers and after removing the outliers the boxplot for all variable as shown below.


![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/16)

Let’s find highly correlated variables to the quality after transforming the data,

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/17)


Step-4:  Modeling, Training and Testing 


a)	Data Splitting:

Splitting data using Caret package 80% training set and 20% validation set.


b)	Feature selection:

Using recursive feature selection from caret package we got 5 top features which are highly correlated to the quality of wine.


![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/18)


c)	Model Building and Training: 

Model1: Taking only top 5 features

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/19)

Model2: Taking all features with preprocessing

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/20)

Model3: Taking all features without preprocessing

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/21)

As we can see from the above results, model_plsRglm3 has the best performance. So, we will consider model_plsRglm3 as our main model.

Plotting variable importance according to the model 3

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/22)


d)Testing: 

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/23)

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/24)


![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/25)

Step 5: Prediction Results

![alt text](https://github.com/poojaumathe/Predicting-the-wine-quality-using-plsRglm-model-in-R/blob/master/Plots/26)









