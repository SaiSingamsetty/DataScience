##Consider the target variable as CustServ.Calls
######### Steps for generating the model ######
# 1. Data set loading
# 2. Data Transformation
# 3. Null Imputation
# 4. Outlier removals
# 5. Scalling
# 6. Correlation
# 7. EDA
# 8. Sampling
# 9. Modeling
# 10. Evaluation (Testing) / Post diagnostics
# 



## Step 1: DataSet loading

getwd()
churn_mv=read.csv("churn_MV.csv")

####### Several functions for different tasks #######
funColToFactos<-function(x){
  x=as.factor(x)
}

rsme<-function(a,p){
  sqrt(mean((a-p)**2))
}

outlierRemoval<-function(x){
  q3=quantile(x, 0.75)
  q1=quantile(x, 0.25)
  
  range= 1.5*IQR(x)
  upperbound=q3+range
  lowerBound=q1-range
  
  x=ifelse((x>upperbound),upperbound,ifelse((x<lowerBound),lowerBound,x))
  return(x)
}

## minmax scalling
minmaxScale<- function(x)
{
  return((x-min(x))/(max(x)-min(x)))
}  

####### Functions ending here #####


names=colnames(churn_mv)

charCols=c("Churn","Intl.Plan","VMail.Plan","State","Area.Code","Phone")
numCols=setdiff(names,charCols)
numCols
?setdiff

## step 2:- data tranformation

churn_mv[,charCols]=lapply(churn_mv[,charCols], funColToFactos)
str(churn_mv)

## step 3:- null values imputation

## remove the null values if it has on the target variable
churn_mv=churn_mv[!is.na(churn_mv$CustServ.Calls),]

## replace the null values if it has on the input variables
## we can replace the null values in different ways 
## 1. with MEAN
## 2. with MEDIAN

## replacing with mean value then find the rmse value

dayMean=mean(churn_mv$Day.Charge)
dayMedian=median(churn_mv$Day.Charge)
churn_mv$dayMean=ifelse(is.na(churn_mv$Daily.Charges.MV),dayMean,churn_mv$Daily.Charges.MV)
churn_mv$dayMedian=ifelse(is.na(churn_mv$Daily.Charges.MV),dayMedian,churn_mv$Daily.Charges.MV)

rsmeMean=rsme(churn_mv$Day.Charge,churn_mv$dayMean)
rsmeMedian=rsme(churn_mv$Day.Charge,churn_mv$dayMedian)
## by observing rsme mean and rsme median we can consider the value which is lower so mean is good for replacing the null values
## removing daily.charges.mv column because we have the original data in day.charges from here on wards we are going to use day.charges column
churn_mv$Daily.Charges.MV=NULL
numCols= numCols[!(numCols %in% "Daily.Charges.MV")]


## Step 4:- Replacing outlier values with the whisker values
boxplot(churn_mv$Eve.Mins)
churn_mv[,numCols]=lapply(churn_mv[,numCols], outlierRemoval)

## inorder to find scalling and correlation we need to seperate the dataset into two different columns
churn_num=churn_mv[,numCols]
churn_cat=churn_mv[,charCols]

## Step 5:- Scalling ###

## MinmaxScalling ##
## we need to scale the data set excluding the target variable

minmaxData=as.data.frame(lapply(churn_num[,-7], minmaxScale))
minmaxData$CustServ.Calls=churn_num$CustServ.Calls
minmaxBind=cbind(minmaxData,churn_cat)

## z score ##
zscoreData=as.data.frame(scale(churn_num[,-7]))
zscoreData$CustServ.Calls=churn_num$CustServ.Calls
zscoreBind=cbind(zscoreData,churn_cat)

## Step6:- correlation between two columns ##
## if the columns are strongly correlated we can elimnate one coulumn by applying EDA with target dataset

## 1. Correlation between continous variable
cor(churn_num)
install.packages("corrplot")
library("corrplot")
corrplot(cor(churn_num))
## by looking at the graph we got to know that
# 1. day.mins - day.charges
# 2. eve.mins - eve.charges
# 3. night.mins - night.charges
# 4. intl.mins - intl.charges
## we can remove one column in 4


## 2. correlation between two categorical variable
# out of 6 categorical variables 3 are useful churn, Intl.plan, VMail.Plan
# we use chi.square test method to find the correlation between two categorical variables
# H0 :- two categorical variables are independent from each other
# HA :- two categorical variables are depedent from each other
# if p<=0.05 reject H0, if p>0.05 accept H0


chisq.test(table(churn_cat$Churn,churn_cat$Intl.Plan)) ## p= 2.2e-16 ## both are dependent

chisq.test(table(churn_cat$Churn,churn_cat$VMail.Plan)) ## p= 5.151e-09 ## both are dependent

chisq.test(table(churn_cat$Intl.Plan,churn_cat$VMail.Plan)) ## p= 0.7785 ## both are independent

## based on above analysis we can remove the column 'churn' from the dataset

## 3. correlation between one continous and one categorical variable
# we use anova for finding the correlation between one continous and once categorical
# H0 :- two categorical variables are independent from each other
# HA :- two categorical variables are depedent from each other
# if p<=0.05 reject H0, if p>0.05 accept H0


summary(aov(minmaxBind$VMail.Message~minmaxBind$VMail.Plan)) # p=2e-16 # both are dependent
summary(aov(minmaxBind$Account.Length~minmaxBind$VMail.Plan)) # p=0.836 # both are undependent
# we need to apply for remaining columns as well

## Remove the coloumns which are strongly correlated 

minmaxBind$Day.Charge=NULL
minmaxBind$Eve.Charge=NULL
minmaxBind$Night.Charge=NULL
minmaxBind$Intl.Charge=NULL
minmaxBind$Churn=NULL
minmaxBind$VMail.Message=NULL
minmaxBind$Phone=NULL
minmaxBind$Area.Code=NULL
minmaxBind$State=NULL
## Step 7:- EDA
## we need to do the EDA for univeriant, bi-variant, multivariant analysis
## we need to findout the inference and verify after the step 9
boxplot(minmaxData$Account.Length)
boxplot(minmaxBind$Intl.Plan,minmaxBind$CustServ.Calls)
library(ggplot2)
ggplot(minmaxBind,aes(x=Intl.Plan,y=CustServ.Calls))+geom_boxplot()


## Step 8:- Sampling
## generating train and test data for the linear regrassion model
## Randome sampling
set.seed(675) ## for generating the random data same for everytime
randomIds = sample( nrow(minmaxBind), nrow(minmaxBind)*0.8)
trainData = minmaxBind[randomIds,]
testData = minmaxBind[-randomIds,]

## stratified sampling
install.packages("caTools")
library(caTools)
train_rows=sample.split(minmaxBind$CustServ.Calls,SplitRatio = 0.8)
trainData=minmaxBind[train_rows,]
testData=minmaxBind[!train_rows,]


## Step 9:- Modeling 
## linear regression model

lin_model=lm(CustServ.Calls~.,data = trainData)
summary(lin_model) 

## Step 10:- Testing
## Test the generated model 

testData$predzsc = predict(lin_model, newdata=testData )


## Find the RMSE for the predicted values

testData$error = testData$CustServ.Calls - testData$predzsc
testData$error_sq = testData$error ** 2
rmse = sqrt(mean(testData$error_sq))
rmse  ## RMSE = 1.087 with random sampling
## RMSE = 1.106492 with stratified sampling

## find the RMSE for z score scalling  and choose the best model

zscoreBind$Day.Charge=NULL
zscoreBind$Eve.Charge=NULL
zscoreBind$Night.Charge=NULL
zscoreBind$Intl.Charge=NULL
zscoreBind$Churn=NULL
zscoreBind$VMail.Message=NULL
zscoreBind$Phone=NULL
zscoreBind$Area.Code=NULL
zscoreBind$State=NULL

## Sampling with zscore dataframe
## Random Sampling
set.seed(674) ## for generating the random data same for everytime
randomIds = sample( nrow(zscoreBind), nrow(zscoreBind)*0.8)
trainData = zscoreBind[randomIds,]
testData = zscoreBind[-randomIds,]

## stratified sampling
train_rows=sample.split(zscoreBind$CustServ.Calls,SplitRatio = 0.8)
trainData=zscoreBind[train_rows,]
testData=zscoreBind[!train_rows,]


## linear regression on zscore dataframe

lin_model=lm(CustServ.Calls~.,data = trainData)
summary(lin_model) 

##
## Test the generated model with zscore

testData$predzsc = predict(lin_model, newdata=testData )

## Find the RMSE for the predicted values of zscore

testData$error = testData$CustServ.Calls - testData$predzsc
testData$error_sq = testData$error ** 2
rmse = sqrt(mean(testData$error_sq))
rmse  # RMSE= 1.1529 with random sampling 
# RMSE= 1.113193 with stratified sampling

## by observing the values of RMSE for minmaxscalling and zscore scalling with random and stratified sampling method below are the observations

## RMSE = 1.087 random sampling with minmax scalling
## RMSE = 1.106492 stratified sampling with minmax scalling
## RMSE= 1.1529 random sampling with zscore
## RMSE= 1.113193 stratified sampling with zscore

###### Observations #######
# Minmax scalling is giving better results then zscore
# some cases randome sampling is giving better some cases stratified sampling giving better results



#################################################################################
#                                                                               #
#                                                                               #
#                                                                               #
#                                                                               #
#                Considering daily.charges.mv as target                         #
#                                                                               #
#                                                                               #
#                                                                               #
#################################################################################

