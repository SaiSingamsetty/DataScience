#D:\Learnings\DataScience\ML\Logistic
data1 = read.csv("D:\\Learnings\\DataScience\\ML\\Logistic\\titanic.csv", na.strings = c(' ','','NA','?','  '))
colsToUse = c('pclass','survived','sex','age','sibsp','parch','fare','cabin','embarked','home_dest')
data1 = data1[,colsToUse]

data1$survived = as.factor(data1$survived)
summary(data1)
## too many missing values
data1$home_dest = NULL
data1$cabin = NULL

###
summary(data1)

###
#install.packages('DMwR')
library(DMwR)
data1 = knnImputation(data1,k = 3)
summary(data1)

### correlation
library(corrplot)
corrplot(cor(data1[,c('age','fare','sibsp','parch','pclass')]),method = 'number')

### 
chisq.test(data1$sex,data1$embarked)
data1$embarked = NULL

### Train Test Split
nrows = 1:nrow(data1)
trainRows = sample(nrows, round(0.7*nrow(data1)))
trainData = data1[trainRows,]
testData = data1[-trainRows,]

### Model
model1 = glm(survived~.-parch-fare,
             data=trainData,
             family = binomial(link = "logit"))

summary(model1)
?glm

preds = predict(model1,testData) # it gives only log odds values, i.e., the exponential part in sigmoid function

preds = predict(model1,testData, type = 'response') # it will return the actual values of sigmoid function


preds = ifelse(preds > 0.5, 1, 0)

#Contigency table
table(preds, testData$survived, dnn = c('preds','actuals'))










