IrisData = read.csv('Iris.csv')
#https://www.kaggle.com/jchen2186/machine-learning-with-iris-dataset/notebook

#Models: Multinomial, kNN, Decision Tree 

##############################################################################################
################################    Simple Regression  ####################################
IrisData = read.csv('Iris.csv')

mydata = IrisData


#Splitting data into workdata and testdata, to test after building a model.
set.seed(143)
trainrows = sample(nrow(mydata),round(0.80*nrow(mydata)))
workdata = mydata[trainrows,]
testdata = mydata[-trainrows,]

#Remove ID
workdata$Id = NULL
testdata$Id = NULL

str(workdata)


# Changing levelnames as they are creating issue while building model, '-' in the middle
levels(workdata$Species) = c("setosa","versicolor","virginica")
levels(testdata$Species) = c("setosa","versicolor","virginica")


# Different workdatas for three linear models, Splitting 
# One vs ALL Approach, we have to train three models seperately as we have three different classes
workdata_setosa = workdata
workdata_setosa$Species = ifelse(workdata$Species == "setosa", 1, 0)
table(workdata_setosa$Species)

workdata_versicolor = workdata
workdata_versicolor$Species = ifelse(workdata$Species == "versicolor", 1, 0)
table(workdata_versicolor$Species)

workdata_virginica = workdata
workdata_virginica$Species = ifelse(workdata$Species == "virginica", 1, 0)
table(workdata_virginica$Species)


names(workdata_virginica)
str(workdata_setosa)

#Regression Models
mymodelsetosa = glm(Species~., data = workdata_setosa, family = binomial(link = "logit"), maxit = 100)
mymodelversicolor = glm(Species~., data = workdata_versicolor, family = binomial(link = "logit"), maxit = 100)
mymodelvirginica = glm(Species~., data = workdata_virginica, family = binomial(link = "logit"), maxit = 100)

#testing three models seperately
Preds_setosa = predict(mymodelsetosa, testdata, type = "response")
Preds_versicolor = predict(mymodelversicolor, testdata, type = "response")
Preds_virginica = predict(mymodelvirginica, testdata, type = "response")

# Combine all the predictions into one dataset.
testdata = cbind(testdata, Preds_setosa, Preds_versicolor, Preds_virginica)

# Highest probability 
#For every test data, 3 models give 3 probabilities. classify them into respective classes w.r.to highest prob
testdata$MyPred = ifelse(testdata$Preds_setosa > testdata$Preds_versicolor, ifelse(testdata$Preds_setosa > testdata$Preds_virginica, 'setosa','virginica'), ifelse(testdata$Preds_versicolor > testdata$Preds_virginica, 'versicolor','virginica') )

#Checking if there are any mismatches
testdata$Err = ifelse(testdata$Species == testdata$MyPred, 0, 1)

#If there are mismatches, where did they occur ?
table(testdata$Err)
testdata[testdata$Err == 1,]




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
















