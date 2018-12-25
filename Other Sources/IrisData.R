IrisData = read.csv('Iris.csv')
#https://www.kaggle.com/jchen2186/machine-learning-with-iris-dataset/notebook

##############################################################################################
################################    Simple Regression  ####################################
IrisData = read.csv('Iris.csv')

workdata = IrisData

#Remove ID
workdata$Id = NULL

str(workdata)

levels(workdata$Species) = c("setosa","versicolor","virginica")
#setosa - 1     versocolor - 2    Virginica - 3 
#workdata$Species = as.numeric(workdata$Species)

library(dummies)
?dummy.data.frame
workdata = dummy.data.frame(workdata, sep = "")

library(corrplot)
corrplot(cor(workdata), method = 'number')

names(workdata)
#Train and test data split
set.seed(143)
trainrows = sample(nrow(workdata),round(0.70*nrow(workdata)))
traindata = workdata[trainrows,]
testdata = workdata[-trainrows,]


#Regression Models
mymodel1 = glm(Speciessetosa~., data = traindata, family = binomial(link = "logit"), maxit =100)

mymodel2 = glm(Speciesversicolor~., data = traindata, family = binomial(link = "logit"), maxit =100)

mymodel3 = glm(Speciesvirginica~., data = traindata, family = binomial(link = "logit"), maxit =100)




##############################################################################################
################################      Multi Nomial Regression  ####################################

IrisData = read.csv('Iris.csv')
#install.packages('nnet')
library(nnet)
?multinom()


workdata = IrisData
workdata$Id = NULL

set.seed(143)
trainrows = sample(nrow(workdata),round(0.70*nrow(workdata)))
traindata = workdata[trainrows,]
testdata = workdata[-trainrows,]

mulmodel = multinom(Species ~. , data = traindata)
summary(mulmodel)

testdata$preds = predict(mulmodel,testdata)

testdata$Err = ifelse(testdata$Species == testdata$preds, 0, 1)

table(testdata$Err)
testdata[testdata$Err == 1,]



#Confusion Matrix
table(testdata$Species, testdata$preds, dnn = c("Actuals","Predictions"))

#ROC Curve

## Have to enquire about Metrics

##############################################################################################
################################      Decision Tree   ####################################

IrisData = read.csv('Iris.csv')

workdata = IrisData
workdata$Id = NULL

set.seed(140)
trainrows = sample(nrow(workdata),round(0.70*nrow(workdata)))
traindata = workdata[trainrows,]
testdata = workdata[-trainrows,]


library(rpart)
dtree1 = rpart(Species ~ ., data = traindata, control = c(cp = 0.001, maxdepth = 5))

library(rpart.plot)
rpart.plot(dtree1)

preds = predict(dtree1, testdata)
preds = as.data.frame(preds)

head(preds)
tail(preds)


testdata$MyPred = ifelse(preds$`Iris-setosa` > preds$`Iris-versicolor`, ifelse(preds$`Iris-setosa` > preds$`Iris-virginica`, 'Iris-setosa','Iris-virginica'), ifelse(preds$`Iris-versicolor` > preds$`Iris-virginica`, 'Iris-versicolor','Iris-virginica') )
                         

testdata$Err = ifelse(testdata$Species == testdata$MyPred, 0, 1)

table(testdata$Err)
testdata[testdata$Err == 1,]


###Metrics



##############################################################################################
################################      kNN Algorithm   ####################################

#https://www.analyticsvidhya.com/blog/2018/03/introduction-k-neighbours-algorithm-clustering/


IrisData = read.csv('Iris.csv')

workdata = IrisData
workdata$Id = NULL

#Scale the data in the dataset
minmaxscale = function(x){
  return ((x-min(x))/(max(x)-min(x)))
}

workdata = as.data.frame(lapply(workdata[,-5], minmaxscale))





set.seed(140)
trainrows = sample(nrow(workdata),round(0.70*nrow(workdata)))
traindata = workdata[trainrows,]
testdata = workdata[-trainrows,]


library(class)
knnmodel = knn(train = traindata,test = testdata, cl = IrisData[trainrows,6], k = 12)


table(knnmodel,IrisData[-trainrows,6], dnn = c('Preds','Acts'))


workdata$Species = IrisData$Species

testdata$ActualSpecies = workdata[-trainrows,5]
testdata$PredSpecies = knnmodel


testdata$Err = ifelse(testdata$ActualSpecies == testdata$PredSpecies, 0, 1)

table(testdata$Err)
testdata[testdata$Err == 1,]
















