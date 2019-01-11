# Titanic Data Set
#survived -> Target
mydata = read.csv('titanic.csv')

names(mydata)
colsToUse = c('pclass','survived','sex','age','fare',
              'sibsp','parch','embarked')
mydata = mydata[,colsToUse]

###
# install.packages('DMwR')
library(DMwR)
mydata = knnImputation(data = mydata,k=5)
summary(mydata)
sum(is.na(mydata))
summary(mydata)

# data2$pclass = as.factor(data2$pclass)
mydata$sex = as.factor(mydata$sex)
mydata$survived = as.factor(mydata$survived)

summary(mydata)

str(mydata)
names(mydata)
summary(mydata)

#### train test split
mydata$survived = as.factor(mydata$survived)
set.seed(123)
rows = 1:nrow(mydata)
trainRows = sample(rows,round(0.7*nrow(mydata)))

trainData = mydata[trainRows,]
testData = mydata[-trainRows,]

prop.table(table(trainData$survived))
prop.table(table(testData$survived))

## decsionTree
library(rpart)
dtree1 = rpart(survived ~.,data=trainData,control=c(cp=0.0001,maxdepth=5))
plotcp(dtree1)

library(rpart.plot)
rpart.plot(dtree1)
# control =c(minsplit =1,maxdepth=3,cp=0))
#cp=0.001 control = c(minsplit =1,maxdepth=5),control = c(cp=0.001)
dtree1

preds_train = predict(dtree1,trainData)
preds_train = as.data.frame(preds_train)
# View(preds)
preds_train$preds_Class = ifelse(preds_train$`1` > 0.5,1,0)
table(trainData$survived,preds_train$preds_Class,dnn=c('actuals','preds'))


preds = predict(dtree1,testData)
preds = as.data.frame(preds)
# View(preds)
preds$preds_Class = ifelse(preds$`1` > 0.5,1,0)
table(testData$survived,preds$preds_Class,dnn=c('actuals','preds'))


##### Bagging
#install.packages('adabag')
library(adabag)
bagModel = bagging(survived~.,data = trainData,
                   mfinal = 70,control=c(maxdepth = 10))


#Train Data 
preds = predict(bagModel,trainData,type='response')
x = table(trainData$survived, preds$class,dnn=c('acts','preds'))
x
#F1 Score
recall_train = x[2,2]/(x[2,1]+x[2,2])
precision_train = x[2,2]/(x[1,2]+x[2,2])
recall_train
precision_train
F1_bagtrain = 2*recall_train*precision_train/(recall_train+precision_train)
F1_bagtrain

#Test Data 
preds = predict(bagModel,testData,type='response')
x = table(testData$survived, preds$class,dnn=c('acts','preds'))
x
#F1 Score
recall_test = x[2,2]/(x[2,1]+x[2,2])
precision_test = x[2,2]/(x[1,2]+x[2,2])
recall_test
precision_test
F1_bagtest = 2*recall_test*precision_test/(recall_test+precision_test)
F1_bagtest




####### Random Forest
#install.packages('randomForest')
library(randomForest)


rfmod = randomForest(survived~.,
                     data = trainData,
                     ntree=150,
                     mtry=5,
                     nodesize=10,maxnodes=20,
                     classwt=c(1,1.3),
                     strata = trainData$survived)
#,classwt = c(1,100000)mtry=5

rfmod
preds = predict(rfmod,trainData,type='response')
x = table(trainData$survived, preds,dnn=c('acts','preds'))
x
#F1 Score
recall_train = x[2,2]/(x[2,1]+x[2,2])
precision_train = x[2,2]/(x[1,2]+x[2,2])
recall_train
precision_train
F1_bagtrain = 2*recall_train*precision_train/(recall_train+precision_train)
F1_bagtrain


preds = predict(rfmod,testData,type='response')
x = table(testData$survived, preds,dnn=c('acts','preds'))
#F1 Score
recall_test = x[2,2]/(x[2,1]+x[2,2])
precision_test = x[2,2]/(x[1,2]+x[2,2])
recall_test
precision_test
F1_bagtest = 2*recall_test*precision_test/(recall_test+precision_test)
F1_bagtest

importance(rfmod)## Var importance
tuneRF(trainData[,-2],trainData[,2])

##### Adaboost
library(adabag)
adaboost = boosting(survived ~ .,
                    data = trainData,
                    mfinal = 100 ,boos = TRUE)
#control =c(minsplit =20,maxdepth=4,cp=0.01,minbucket=20))
importanceplot(adaboost)
adaboost$importance
preds = predict(adaboost,trainData,type='response')
table(trainData$survived, preds$class,dnn=c('acts','preds'))

preds = predict(adaboost,testData,type='response')
table(testData$survived, preds$class,dnn=c('acts','preds'))


#######  Use the Universal Bank dataset
trainData$survived = as.numeric(as.character(trainData$survived))
library(gbm)
gbmmodel = gbm(survived ~ .,data = trainData,
               distribution = 'bernoulli',
               n.trees =3500,
               interaction.depth = 7,
               bag.fraction = 0.6,
               n.minobsinnode=10,
               shrinkage = 0.005,
               verbose = T,
               train.fraction = 0.8)

preds = predict(gbmmodel,trainData,n.trees = 3500,type = 'response')
preds_class = ifelse(preds >0.5,1,0)
table(trainData$survived, preds_class,dnn = c('acts','preds'))


preds = predict(gbmmodel,testData,n.trees = 3500,type = 'response')
preds_class = ifelse(preds >0.5,1,0)
table(testData$survived, preds_class,dnn = c('acts','preds'))
summary(gbmmodel)






















