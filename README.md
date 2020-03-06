# Predicting-the-wine-quality-using-plsRglm-model-in-R

Problem Statement: Using only partial least squares regression for generalized linear models (the plsRglm package in R) using caret 
package, build an ensemble model to predict the quality score given to each wine from the Vinho Verde region of Portugal.

Project Objective: Predict the quality of Wine

Data:  https://archive.ics.uci.edu/ml/datasets/Wine+Quality
The data consists of 11 features which are: fixed acidity, volatile acidity, citric acid, residual sugar, 
chlorides, free sulfur dioxide, total sulfur dioxide, density, pH, sulphates, alcohol; and 1 output variable which is quality of wine. There are two data sets for red and white wine types. Data sets will be concatenated, and general model is going to be trained for both red and white wine types.

Programming Language:  R

Let’s get started….

Step-1:  Installation of all required packages and libraries
In this Project, I am using Caret package. The caret package (short for Classification and Regression Training) contains 
functions to streamline the model training process for complex regression and classification problems.


Step-2:  Importing or Loading the data


 
 
The above figure shows the data and I have created one color column in both dataset so that would be easier to understand the data after concatenation.
 
I have used rbind function to concatenate the dataset.

Step-3:  Exploratory Data Analysis and Data Preprocessing
In statistics, exploratory data analysis is an approach to analyzing data sets to summarize their main characteristics, often with visual methods.
a)	Understand the data: 
By getting structure and summary of data is the way to understand the data.

 

 
The above pictures show the first and last 6 rows of the dataset after concatenation.
 
 
  
In summary and structure of the data we can see description of each attribute.

b)	Missing Values: 
Checking missing values if any using is.na function in R. We can see there are no missing values in dataset which is good for our model performance.
 
c)	Exploring the attributes:
Below plots show the quality of wine and level of alcohol based on wine color
  
Below plots show the density, level of volatile acidity, chlorides, and density of wine based on color.

   
In the below plot we can say that there are same amount of red and white wines with quality '3', '4' and '9', more red wines with quality '5' and more white wines with quality "6", "7" and "8".
   

d)	Finding Correlation between the attributes with quality:

Finding correlation is an important task in machine learning projects as we need to know about the correlation between each attribute with outcome attribute.
 
 

 
So, the above correlation graphs show the correlation between all attributes where we can see alcohol is more correlated to the quality of wine. First correlation graph is without melting(reshaping) the values and other has reshaped values.

  
The above graphs show the density vs alcohol correlation by wine color and quality.
 
As we can observe from the graphs that Wine with high alcohol percentage has quality level 7, wine with less alcohol percentage is quality level 5.

e)	Frequency distribution: 
The height of each bar shows how many falls into each range. Plotting histogram using hist() function , we can visualize the frequency distribution of each attribute.   
f)	Outliers:

Outlier is a data point that differs significantly from other observations.
Let’s check the outliers in our data…

 
There are so many outliers in each variable which is nit good for the model performance. We need to remove them.

g)	Skewness: 

In probability theory and statistics, skewness is a measure of the asymmetry of the probability distribution of a real-valued random variable about its mean. The skewness value can be positive or negative, or undefined.

 
Skewness values are not that great, as in data is bit skewed.

h)	Data Transformation / Preparation:

From the above results as we know that our data is bit skewed and there are outliers so here, we are using Box cox transformation method to transform the data.

 

So,  here is the new data (transformed data) look like,

 

Creating a function to remove outliers and after removing the outliers the boxplot for all variable as shown below.
 


Let’s find highly correlated variables to the quality after transforming the data,
 
Step-4:  Modeling, Training and Testing 
a)	Data Splitting:

Splitting data using Caret package 80% training set and 20% validation set.

 

b)	Feature selection:
Using recursive feature selection from caret package we got 5 top features which are highly correlated to the quality of wine.

 
 

c)	Model Building and Training: 

Model1: Taking only top 5 features
 

Results:
 
 


Model2: Taking all features with preprocessing
 

Results:

 
 

Model3: Taking all features with preprocessing
 

Results:
 

 

As we can see from the above results, model_plsRglm3 has the best performance. So, we will consider model_plsRglm3 as our main model.

Plotting variable importance according to the model 3
 
 
d)Testing: 
 
Results:
 
 
Results for validation set are pretty much good.
Variable importance according to the validation set,
 
Step-5:  Predictions
 
Results:

 
 



