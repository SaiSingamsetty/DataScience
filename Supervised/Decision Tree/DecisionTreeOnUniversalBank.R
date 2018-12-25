data1 = read.csv('universalBank.csv')
data1$ID = NULL

str(data1)
#Data conversions

data1$Personal.Loan = as.factor(data1$Personal.Loan)
data1$Securities.Account = as.factor(data1$Securities.Account)
data1$CD.Account   = as.factor(data1$CD.Account)
data1$Online   = as.factor(data1$Online)
data1$CreditCard    = as.factor(data1$CreditCard)
data1$Education    = as.factor(data1$Education)



names(data1)
summary(data1)

#Train and Test split
set.seed(567)
rows = 1:nrow(data1)
trainRows = sample(rows,round(0.7*nrow(data1)))

trainData = data1[trainRows,]
testData = data1[-trainRows,]

#Decision Tree
#install.packages('rpart')
library(rpart)
dtree1 = rpart(Personal.Loan~.,data = trainData,control=c(cp=0.0001,maxdepth=5))
#reduce cp to increase complexity
plotcp(dtree1)
#D Tree Plot
#install.packages('rpart.plot')
library(rpart.plot)
rpart.plot(dtree1)

#Prediction
preds = predict(dtree1, testData)
preds = as.data.frame(preds)

#testData$Predsclass = preds
head(preds)

testData$Predsclass = ifelse(preds$`1`> 0.5 , 1, 0)
table(testData$Predsclass)

#Confusion Matrix
table(testData$Personal.Loan,testData$Predsclass,dnn = c('Acts','Preds'))

#ROC Curve
#install.packages('ROCR')
library(gplots)
library(ROCR)
pred_ROCR = prediction(testData$Predsclass, testData$Personal.Loan)
perf_ROCR = performance(pred_ROCR, 'tpr', 'fpr')

plot(perf_ROCR,colorize = T, print.cutoffs.at=seq(0,1,by=0.1),
     text.adj=c(1.2,1.2), avg="threshold", lwd=3,
     main= "ROC")
















