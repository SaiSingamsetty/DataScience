################################################################
####### References
#Null and Residual Deviance
#https://analyticsdataexploration.com/deviance-and-aic-for-logistic-regression-in-r/



################################################################

dataset = read.csv('universalBank.csv')

summary(dataset)
str(dataset)
names(dataset)

#removing unnecessary columns
x = c(1,5)
dataset = dataset[,-x]
names(dataset)

#Outliers 
#Remove if needed in the second GO. 
boxplot(dataset)

boxplot(dataset$CCAvg)

y = summary(dataset$Income)
top = y[5] + (1.5 * IQR(dataset$Income))

dataset$Income = ifelse(dataset$Income > top, top, dataset$Income)

y = summary(dataset$CCAvg)
top = y[5] + (1.5 * IQR(dataset$CCAvg))

dataset$CCAvg = ifelse(dataset$CCAvg > top, top, dataset$CCAvg)

y = summary(dataset$Mortgage)
top = y[5] + (1.5 * IQR(dataset$Mortgage))

dataset$Mortgage = ifelse(dataset$Mortgage > top, top, dataset$Mortgage)

# Scaling
min_max_scaling_function = function(x){
  return( (x-min(x)) / (max(x)-min(x)) ) 
}

table(dataset$Personal.Loan)


for(i in 1:ncol(dataset)){
  dataset[,i] = min_max_scaling_function(dataset[,i])  
}


# Correlation
names(dataset)
library(corrplot)
?corrplot
corrplot(cor(dataset), 'number') # Drop Age as correlation is too high
dataset$Age = NULL



#train test split
set.seed(111)

nrows = 1:nrow(dataset)
trainRows = sample(nrows, round(0.7*nrow(dataset)))
trainData = dataset[trainRows,]
testData = dataset[-trainRows,]


#model build
dataset$Personal.Loan
model1 = glm(Personal.Loan~.-Experience-CCAvg-Mortgage,
             data=trainData,
             family = binomial(link = "logit"))
summary(model1)


testData$Preds = predict(model1,testData, type = 'response')

testData$Preds1 = ifelse(testData$Preds > 0.6 , 1, 0)

#Confusion Matrix

cm = table(testData$Personal.Loan, testData$Preds1, dnn = c('Acts','Preds'))
cm
#Recall : Out of all actual 'Yes', how many you have predicted correctly as 'Yes'
## Recall =>TP/actual yes
##True Positive Rate: When it's actually yes, how often does it predict yes?
recall_value = cm[2,2]/(cm[2,1]+cm[2,2])
#Precsion: Out of all Predicted 'yes', how many you have predicted correctly as 'Yes'
## Precision => TP/predicted yes
##Precision: When it predicts yes, how often is it correct?
precision_value = cm[2,2]/(cm[1,2] + cm[2,2])

## F- Scofre => This is a weighted average of the true positive rate (recall) and precision 
fscore = 2 * recall_value * precision_value / (recall_value + precision_value)

## Accuracy => (TP+TN)/total
accuracy = (cm[1,1] + cm[2,2]) / (cm[1,1] + cm[1,2] + cm[2,1] + cm[2,2]) 


##########
#ROC Curve
#########
library(ROCR)
predROC = prediction(predictions = testData$Preds1, labels = testData$Personal.Loan)
perfROC = performance(predROC, 'tpr', 'fpr')

plot(perfROC)


## Area under Curve
#install.packages('pROC')
library(pROC)
rocobject = roc(testData$Personal.Loan, testData$Preds1)
auc(rocobject)















