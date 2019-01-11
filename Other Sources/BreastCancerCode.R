# Kernel by manish
# https://www.kaggle.com/gargmanish/basic-machine-learning-with-cancer
# Original https://www.kaggle.com/uciml/breast-cancer-wisconsin-data/kernels

bcdata = read.csv('BreastCancer.csv')
str(bcdata)
head(bcdata)
names(bcdata)

#Remove the last column: It is not useful
bcdata = bcdata[,-33]
#Rmove the ID Column as well, It is not useful for analysis
bcdata = bcdata[,-1]

#If you observe the data above has 10 features common for _mean, _se, _worst
features_mean = bcdata[,2:11]
features_se = bcdata[,12:21]
features_worst = bcdata[,22:31]

bcdata$diagnosis = ifelse(bcdata$diagnosis == "B", 0, 1)

summary(bcdata)
names(bcdata)

#plotting both types of Cancer 
library(ggplot2)

ggplot(bcdata, aes(diagnosis))+
  geom_bar() +
  geom_text(aes(label = ..count..), stat = 'count') #Benign tumour cases are more



#Check correlation: Feature selection
library(corrplot)

#_mean

corrplot(cor(features_mean), method = 'number', type = 'full')
#Observing all the correlations,
features_mean = features_mean[,c(1,2,5,6,9,10)]


# Train-test split
set.seed(123)
trainrows = sample(1:nrow(bcdata),size = 0.70*(nrow(bcdata)))
traindata = features_mean[trainrows,]
testdata = features_mean[-trainrows,]
trainDiag = bcdata[trainrows,'diagnosis']
testDiag = bcdata[-trainrows,'diagnosis']
traindata$diagnosis = trainDiag
testdata$diagnosis = testDiag

#Model Build
library(randomForest)
?randomForest

rfmodel = randomForest(diagnosis~.,
                       data = traindata,
                       ntree = 150,
                       mtry = 5, 
                       nodesize = 5, maxnodes = 10,
                       classwt = c(1,1.5),
                       strata = traindata$diagnosis)
rfmodel

preds = predict(rfmodel, traindata, type = 'response')
traindata$preds = ifelse(preds > 0.5, 1, 0)

table(traindata$diagnosis, traindata$preds)
Accuracy = (150+237)/(150+237+3+8)



















