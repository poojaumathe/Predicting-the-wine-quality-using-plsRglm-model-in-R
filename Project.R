# Predicting the quality of wine using Partial least square 
# regression models for genearalized linear model using Caret package.

#Pooja Umathe

# Importing required Libraries
install.packages("RCurl")
library(RCurl)

install.packages("ggplot2")
library(ggplot2)

install.packages("GGally")
library(GGally)

install.packages("dplyr")
library("dplyr")

install.packages("corrplot")
library(corrplot)

install.packages("caret")
library(caret)

install.packages("AppliedPredictiveModeling")
library(AppliedPredictiveModeling)

install.packages("plsRglm")
library(plsRglm)

install.packages("plsdepot")
library(plsdepot)

install.packages("plsdof")
library(plsdof)

install.packages("e1071")
library(e1071)

install.packages("mlbench")
library(mlbench)

install.packages("Metrics")
library("Metrics")

library(reshape2)

library(MASS)

require(lattice)


# 1. Data importing and Preprocessing

fileURL1 = 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv'
fileURL2 = 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv'


white = read.csv(fileURL1, header = T, sep = ";")
red = read.csv(fileURL2, header = T, sep = ";")

# Creating new column "color" in dataset based on color
white['color'] <- 'white'
red['color'] <- 'red'

View(white)
View(red)

# Getting the dimesions of data

dim(white)
dim(red)


# Checking missing values
sum(is.na(white))
sum(is.na(red))


# Concatenating the white and red wine data together

data <- rbind(white, red)

dim(data)

# Showing first 6 rows
head(data)

# Showing last 6 rows
tail(data)

View(data)

# Getting the structure of data
str(data)

# Getting Summary
summary(data)

sum(is.na(data))

# Creating new data without color column

drops <- c("color")
data1 = data[ , !(names(data) %in% drops)]

dim(data1)

head(data1)

# Getting summary and quality of wines
summary(data$quality)

table(data$quality)

qplot(quality, data = data, fill = color, binwidth = 1) +
  scale_x_continuous(breaks = seq(3,10,1), lim = c(3,10)) + scale_y_sqrt()


# Getting level of alcohol

qplot(alcohol, data = data, fill = color, binwidth = 0.5) +
  scale_x_continuous(breaks = seq(8,15,0.5), lim = c(8,15))


# Getting density of wines

qplot(density, data = data, fill = color, binwidth = 0.0002) +
  scale_x_log10(lim = c(min(data$density), 1.00370), 
                breaks = seq(min(data$density), 1.00370, 0.002))

# Getting level of Volatile acidity

qplot(volatile.acidity, data = data, fill = color, binwidth = 0.001) +
  scale_x_log10(breaks = seq(min(data$volatile.acidity), 
                             max(data$volatile.acidity), 0.1))

# Getting level of chlorides

qplot(chlorides, data = data, fill = color, binwidth = 0.01) +
  scale_x_log10(breaks = seq(min(data$chlorides), max(data$chlorides), 0.1))


# Ploting density of quality by color
qplot(quality, data = data, binwidth = 1, color = color, geom = "density") + 
  scale_x_continuous(breaks = seq(3, 9, 1))

# As we can see in the graph there are same amount of red and white wines with 
# quality '3', '4' and '9', more red wines with quality '5' and more white 
# wines with quality "6", "7" and "8".

# Finding correlation

correlation = round(cor(data1, method = "pearson"), 3)

View(correlation)

col<- colorRampPalette(c("red", "white", "dark green"))(20)
heatmap(correlation, col=col, symm=TRUE)

# Reshaping the correlation values using melt function
melted_correlation <- melt(correlation)

View(melted_correlation)

# Plot heatmap with melted correlated values
ggplot(data = melted_correlation, aes(x=Var1, y=Var2, fill=value)) + geom_tile()


# As we can see alcohol is highly correlated with the quality

ggplot(data = data, 
       aes(x = density, y = alcohol, color = color)) +
  geom_point(alpha = 1/6, position = position_jitter(h = 0), size = 3) +
  geom_smooth(method = 'lm') +
  coord_cartesian(xlim=c(min(data$density),1.005), ylim=c(8,15)) +
  xlab('Density') +
  ylab('Alcohol') +
  ggtitle('Density vs. Alcohol correlation by Color')



ggplot(data = data, 
       aes(x = density, y = alcohol, color = factor(quality))) +
  geom_point(alpha = 1/2, position = position_jitter(h = 0), size = 2) +
  coord_cartesian(xlim=c(min(data$density),1.005), ylim=c(8,15)) +
  scale_color_brewer(type='qual') +
  xlab('Density') +
  ylab('Alcohol') +
  ggtitle('Density vs. Alcohol correlation by Quality')


ggplot(data = data, 
       aes(x = density, y = alcohol) )+
  facet_wrap( ~ quality) +
  geom_boxplot() +
  xlab('Density') +
  ylab('Alcohol') +
  ggtitle('Density vs. Alcohol correlation by Quality')

# As we can observe from graph that Wine with high alcohol percentage has quality 
# level 7, wine with less alcohol percentage is quality level 5.

# Plotting Histogram for each attribute

attach(data1)

par(mfrow=c(2,2), oma = c(1,1,0,0) + 0.1, mar = c(3,3,1,1) + 0.1)

barplot((table(quality)), col=c("pink", "yellow", "slategray1", "orange", "blue", "Green"))
mtext("Quality", side=1, outer=F, line=2, cex=0.8)

truehist(fixed.acidity, h = 0.5, col="skyblue")
mtext("Fixed Acidity", side=1, outer=F, line=2, cex=0.8)

truehist(volatile.acidity, h = 0.05, col="skyblue")
mtext("Volatile Acidity", side=1, outer=F, line=2, cex=0.8)

truehist(citric.acid, h = 0.1, col="skyblue")
mtext("Citric Acid", side=1, outer=F, line=2, cex=0.8)

truehist(residual.sugar, h = 5, col="skyblue")
mtext("Residual Sugar", side=1, outer=F, line=2, cex=0.8)

truehist(chlorides, h = 0.01, col="skyblue")
mtext("Chloride", side=1, outer=F, line=2, cex=0.8)

truehist(alcohol, h = 0.5, col="skyblue")
mtext("Alcohol", side=1, outer=F, line=2, cex=0.8)

truehist(density, h = 0.005, col="skyblue")
mtext("Density", side=1, outer=F, line=2, cex=0.8)

truehist(free.sulfur.dioxide, h = 10, col="skyblue")
mtext("Free Sulfur Dioxide", side=1, outer=F, line=2, cex=0.8)

truehist(pH, h = 0.1, col="skyblue")
mtext("pH values", side=1, outer=F, line=2, cex=0.8)

truehist(sulphates, h = 0.1, col="skyblue")
mtext("sulphates", side=1, outer=F, line=2, cex=0.8)

truehist(total.sulfur.dioxide, h = 20, col="skyblue")
mtext("total.sulfur.dioxide", side=1, outer=F, line=2, cex=0.8)

# Checking Outliers

boxplot(data1)



# Checking skewness of the data

skewness(quality)

skewness(chlorides)

skewness(free.sulfur.dioxide)

skewness(residual.sugar)

skewness(alcohol)

skewness(citric.acid)

skewness(density)

skewness(fixed.acidity)

skewness(volatile.acidity)

skewness(total.sulfur.dioxide)

skewness(sulphates)

skewness(pH)


# Data Transformation / Preparation
# Box Cox Transformation

preprocess_data1 <- preProcess(data1[,1:11], c("BoxCox", "center", "scale"))
new_data1 <- data.frame(trans = predict(preprocess_data1, data1))

colnames(new_data1)

#Skewness - Transformed Data

skewness(new_data1$trans.quality)

skewness(new_data1$trans.chlorides)

skewness(new_data1$trans.free.sulfur.dioxide)

skewness(new_data1$trans.residual.sugar)

skewness(new_data1$trans.alcohol)

skewness(new_data1$trans.citric.acid)

skewness(new_data1$trans.density)

skewness(new_data1$trans.fixed.acidity)

skewness(new_data1$trans.volatile.acidity)

skewness(new_data1$trans.total.sulfur.dioxide)

skewness(new_data1$trans.sulphates)

skewness(new_data1$trans.pH)

# After the transformation of data we can see the skewness of variables are much better

View(new_data1)

# Removal of Outliers

dim(new_data1)

summary(new_data1)

str(new_data1)

# Creating a Function which takes our data as input and returns 
#data without outliers

clear_data <- function(data){
  
  # each feature of input data is analysed
  for (i in 1:ncol(data)){
    # particular feature observations
    vec <- data[, i]
    
    # values those are out of 1.5 * IQR
    vec_out <- boxplot.stats(vec)$out
    
    # all outlier values found in feature vector assigned as NA
    vec[vec %in% vec_out] <- NA
    
    # data feature is updated
    data[, i] <- vec
  }
  
  # only complete observation data subset is returned
  data[complete.cases(data), ]
}

# Creating new data without outliers using defined function
new <- clear_data(new_data1)

dim(new)

boxplot(new)

# As we can see in above boxplot outliers has been removed

correlation_new = round(cor(new, method = "pearson"), 3)

correlation_new

View(correlation_new)
View(correlation)

# After comparing both correlation tables(before transformation and after transformation)
# we can say that Transformed correlated values are much better than the data before 
#tranformation


highlyCorrelated <- findCorrelation(correlation_new, cutoff=0.4)

print(highlyCorrelated)

set.seed(1000)

control = trainControl(method="repeatedcv", number=10, repeats=3)

# train the model
model_features <- train(trans.quality~., data=new, method="rpart", trControl=control)

importance = varImp(model_features, scale=FALSE)
importance

plot(importance)

# splitting data into training and validation set
data_split <- createDataPartition(y = new$trans.quality,p=0.8,list = FALSE)

training_set <- new[data_split,]
val_set <- new[-data_split,]

trainX <- training_set[, -ncol(training_set)]
trainY <- training_set$trans.quality

dim(training_set)
dim(val_set) 

str(training_set)

# feature selection
# prepare training scheme

set.seed(2020)

# 

rctrl1 <- rfeControl(method = "cv",
                     number = 3,
                     returnResamp = "all",
                     functions = caretFuncs,
                     saveDetails = TRUE)

model <- rfe(trans.quality ~ ., data = training_set,
             sizes = c(1, 5, 10, 15),
             method = "knn",
             trControl = trainControl(method = "cv",
                                      classProbs = TRUE),
             tuneGrid = data.frame(k = 1:10),
             rfeControl = rctrl1)

model

model$fit

plot(model, type=c("g", "o"))

# From feature selection method using Caret we got 5 top features from 11.
# trans.alcohol, trans.density, trans.chlorides, trans.volatile.acidity, trans.citric.acid


# Model Building

# Model1
#Taking only the top 5 predictors

predictors <- c("trans.alcohol", "trans.density", "trans.chlorides", 
                "trans.volatile.acidity", "trans.citric.acid")

outcomeName <- "trans.quality"

set.seed(100)

model_plsRglm1 <- train(training_set[,predictors],training_set[,outcomeName],
                       method='plsRglm', preProcess = c("center", "scale"))


model_plsRglm1

plot(model_plsRglm1)

# Model2- Taking all features with preprocessing
set.seed(2020)

model_plsRglm2 <- train(trainX, trainY, method='plsRglm', preProcess = c("center","scale"))


model_plsRglm2


varImp(object=model_plsRglm2)

plot(model_plsRglm2)

# Model 3 -taking all features without preprocessing
set.seed(840)

model_plsRglm3 <- train(training_set,trainY, method='plsRglm')

model_plsRglm3

plot(model_plsRglm3)

# As we can see from above three models model_plsRglm3 has the best performance.
# So we will consider model_plsRglm3 as our main model.

# Plotting Variable importance for plsRglm_model3

plot(varImp(object=model_plsRglm3),main="plsRglm - Variable Importance")

ggplot(varImp(model_plsRglm3))


# Testing on validation set
set.seed(568)

model_validation <- train(val_set,val_set$trans.quality,
                        method='plsRglm')

model_validation

plot(model_validation)
ggplot(varImp(model_validation))


#Predictions

predict <- val_set$trans.quality

predictions <- predict(model_plsRglm3, val_set)

RMSE(predictions, predict)
R2(predictions, predict, form = "traditional")
MAE(predictions,predict)


 