data1 = read.csv("C:/Users/phsivale/Documents/Trainings/titanic.csv",
                 na.strings=c(""," ","NA","?","  "))
names(data1)
colsToUse = c('pclass','survived','sex','age','fare',
              'sibsp','parch','embarked')
data1 = data1[,colsToUse]

str(data1)
###
# install.packages('DMwR')
library(DMwR)
data2 = knnImputation(data = data1,k=5)
summary(data2)
sum(is.na(data2))
summary(data1)

# data2$pclass = as.factor(data2$pclass)
data2$sex = as.factor(data2$sex)
data2$survived = as.factor(data2$survived)

summary(data2)

#### Handling Sibsp and Parch

table(data1$sibsp)

# data2$sibsp_cat = ifelse(data2$sibsp > 1,'>2',data2$sibsp)
# data2$sibsp_cat = as.factor(data2$sibsp_cat)
# 
# table(data1$parch)
# data2$parch_cat = ifelse(data2$parch > 1,'>1',data2$parch)
# data2$parch_cat = as.factor(data2$parch_cat)
summary(data2)

# ### Dropping sibsp and parch
# data2$sibsp = NULL
# data2$parch = NULL

summary(data2)

# data2$pclass = as.factor(data2$pclass)
hist(data2$fare)
quantile(data2$fare,1)

data2$fare[data2$fare > quantile(data2$fare,0.99)] = quantile(data2$fare,0.99)
data2$fare = sqrt(data2$fare)
summary(data2)

##### train test split
data2$survived = as.factor(data2$survived)
set.seed(567)
rows = 1:nrow(data2)
trainRows = sample(rows,round(0.7*nrow(data2)))

trainData = data2[trainRows,]
testData = data2[-trainRows,]

prop.table(table(trainData$survived))
prop.table(table(testData$survived))

summary(data2)

## decsionTree
library(rpart)
dtree1 = rpart(survived ~.,data=trainData,control=c(cp=0.0001,maxdepth=5))
plotcp(dtree1)

library(rpart.plot)
rpart.plot(dtree1)
               # control =c(minsplit =1,maxdepth=3,cp=0))
#cp=0.001 control = c(minsplit =1,maxdepth=5),control = c(cp=0.001)
dtree1



plot(dtree1,main="Classification Tree for survived Class",
     margin=0.1,uniform=TRUE)
text(dtree1,use.n=T)


library(rpart.plot)
rpart.plot(dtree1)

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


#### ROC
library(ROCR)
### add the ROC graph of credit_model1 on the same plot 
pred = prediction(preds , testData$survived)
perf= performance(pred, "tpr","fpr")
# plot(perf,colorize = T)

plot(perf, colorize=T, print.cutoffs.at=seq(0,1,by=0.1), 
     text.adj=c(1.2,1.2), avg="threshold", lwd=3,
     main= "ROC")

### AUC for churn model 

AUC_1 = performance(pred, measure = 'auc')@y.values[[1]]
AUC_1


### 
library(C50)

dtree2 = C5.0(survived ~.,data=trainData)
plot(dtree2)

preds = predict(dtree2, testData)
table(testData$survived,preds,dnn=c('actuals','preds'))



##### Bagging

library(adabag)
bagModel = bagging(survived~.,data = trainData,
                   mfinal = 50,control=c(maxdepth = 10))
preds = predict(bagModel,trainData,type='response')
table(trainData$survived, preds$class,dnn=c('acts','preds'))

preds = predict(bagModel,testData,type='response')
table(testData$survived, preds$class,dnn=c('acts','preds'))


####### Random Forest
library(randomForest)
rfmod = randomForest(survived~.,
                     data = trainData,
                     ntree=150,
                     mtry=4,
                     nodesize=5,maxnodes=10,
                     classwt=c(1,1.5),
                     strata = trainData$survived)
#,classwt = c(1,100000)mtry=5
              
rfmod
preds = predict(rfmod,trainData,type='response')
table(trainData$survived, preds,dnn=c('acts','preds'))

preds = predict(rfmod,testData,type='response')
table(testData$survived, preds,dnn=c('acts','preds'))

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
  