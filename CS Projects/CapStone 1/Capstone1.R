########################################################################################
#########################################################################
#### CustServ.Calls as Target Variable: Linear Regression Model
#########################################################################
########################################################################################

# Load the Dataset
churn_mv = read.csv("Churn_MV.csv")

# Functions Used
toFactor <- function(x){
  x = as.factor(x)
}

rmse <- function(act, pred){
  return(sqrt(mean((act-pred)**2)))
}

minmaxscale = function(x){
  return((x-min(x))/(max(x)-min(x)))
}

Removeoutliers = function(x){
  q3=quantile(x, 0.75, na.rm = TRUE)
  q1=quantile(x, 0.25, na.rm = TRUE)
  
  range= 1.5*IQR(x, na.rm = TRUE)
  upperbound=q3+range
  lowerBound=q1-range
  
  x=ifelse((x>upperbound),upperbound,ifelse((x<lowerBound),lowerBound,x))
  return(x)
}

#Functions end

names = colnames(churn_mv)
charCols=c("Churn","Intl.Plan","VMail.Plan","State","Area.Code","Phone")
numCols=setdiff(names,charCols)
numCols

#remove(x)  : will remove that variable from environment

######  Data Transformation ######

str(churn_mv)
churn_mv[,charCols] = lapply(churn_mv[,charCols], toFactor)
str(churn_mv)

######  Null Imputation ######

#The records are unnecessary for prediction if Target variable has NA's
churn_mv = churn_mv[!is.na(churn_mv$CustServ.Calls),]
summary(churn_mv)

#Daily.Charges.MV has some NA's yet.(One of the input variable)
#We can replace those NA's using Mean or Median

#Daily.Charges.MV and Day.Charge are same. But Daily.Charges.MV holds some NA's for our practice
churn_mv$Daily.Charges.MV.Mean = ifelse(is.na(churn_mv$Daily.Charges.MV),mean(churn_mv$Day.Charge),churn_mv$Daily.Charges.MV)
churn_mv$Daily.Charges.MV.Median = ifelse(is.na(churn_mv$Daily.Charges.MV),median(churn_mv$Day.Charge),churn_mv$Daily.Charges.MV)

rmseMean = rmse(churn_mv$Day.Charge, churn_mv$Daily.Charges.MV.Mean)
rmseMedian = rmse(churn_mv$Day.Charge, churn_mv$Daily.Charges.MV.Median)
#rmseMean is less than rmseMedian, so mean is a better way to impute NA's than Median

#Now we can remove Daily.Charges.MV column as we found the best imputation way (mean) and we have 
#added a new col as Daily.Charges.MV.Mean. removing Day.Charges as well (no use of having two same cols, indeed we can keep
#one column Daily.Charges.MV.Mean as we have got that through mean imputation)

#dropping two cols and median one as well
churn_mv$Day.Charge = NULL
churn_mv$Daily.Charges.MV = NULL
churn_mv$Daily.Charges.MV.Median = NULL



######  Outlier Treatment ######
boxplot(churn_mv)

#Since Columns has got updated, Let us refresh once
names = colnames(churn_mv)
charCols=c("Churn","Intl.Plan","VMail.Plan","State","Area.Code","Phone")
numCols=setdiff(names,charCols)
#End

churn_mv[,numCols]=lapply(churn_mv[,numCols], Removeoutliers)


#########################################################################
#Seperate to Numeric and Category columns before Scaling and Correlation
#########################################################################

churn_num = churn_mv[,numCols]
churn_cat = churn_mv[,charCols]


######  Scaling ######

# Min Max Scaling 
# Scale the data by excluding Target Variable
churn_minmax = as.data.frame(lapply(churn_num[,-7], minmaxscale))
churn_minmax$CustServ.Calls = churn_num$CustServ.Calls

minmaxBind = cbind(churn_minmax, churn_cat)

# Z Scaling
churn_Zscale = as.data.frame(scale(churn_num[,-7]))
churn_Zscale$CustServ.Calls = churn_num$CustServ.Calls

zscalebind = cbind(churn_Zscale, churn_cat)


remove(churn_minmax)
remove(churn_Zscale)

######  Correlation ######

# For the numeric columns

library(corrplot)
corrplot(cor(churn_num), method = 'number')
?corrplot

# Observing the graph we got to know that the below columns are highly correlated
# Eve.Mins ~ Eve.Charge
# Night.Mins ~ Night.Charge
# Intl.Mins ~ Intl.Charge
# Day.Mins ~ Daily.Charges.MV.Mean

# We can remove one column in each row


# For the Categoric Columns

# We use Chi.Square test to determine the relation/Correlation between categoric columns
# H0 :- two categorical variables are independent from each other
# HA :- two categorical variables are depedent on each other
# if p<=0.05 Reject H0 and Accept HA
# https://www.statisticshowto.datasciencecentral.com/p-value/

chisq.test(churn_cat$Churn,churn_cat$Intl.Plan) # p <= 0.05
chisq.test(churn_cat$Churn,churn_cat$VMail.Plan) # p <= 0.05

chisq.test(churn_cat$Intl.Plan,churn_cat$VMail.Plan) # p > 0.05, both are independent

# SO based on the correlations we got, we can remove Churn column



# For numeric and Categoric - done by ANOVA
p1 = aov(minmaxBind$Account.Length ~ minmaxBind$Churn)
p2 = aov(minmaxBind$Account.Length ~ minmaxBind$VMail.Plan)
p3 = aov(minmaxBind$VMail.Message ~ minmaxBind$VMail.Plan)
summary(aov(minmaxBind$Intl.Charge ~ minmaxBind$Intl.Plan))
summary(p1)
remove(p1)
remove(p2)
remove(p3)
# This should be done for all the columns in Dataset

########################################################################################
########################################################################################
# 1. Now considering the minmaxBind and do all the necessary steps.
########################################################################################
########################################################################################

# Removing the columns:
minmaxBind$Day.Charge=NULL
minmaxBind$Eve.Charge=NULL
minmaxBind$Night.Charge=NULL
minmaxBind$Intl.Charge=NULL
minmaxBind$Churn=NULL
minmaxBind$VMail.Message=NULL
minmaxBind$Phone=NULL
minmaxBind$Area.Code=NULL
minmaxBind$State=NULL


######  EDA ######
#Perform EDA univariant, bi variant and Multivariant analysis and draw inferences from data



######  Sampling ######

## generating train and test data for the linear regression model
## Random sampling
set.seed(143) 
trainrows = sample( nrow(minmaxBind), nrow(minmaxBind)*0.8)
trainData = minmaxBind[trainrows,]
testData = minmaxBind[-trainrows,]

## stratified sampling
#install.packages("caTools")
library(caTools)
trainrows=sample.split(minmaxBind$CustServ.Calls,SplitRatio = 0.8)
trainData=minmaxBind[trainrows,]
testData=minmaxBind[!trainrows,]



######  Model Building ######

lin_model=lm(CustServ.Calls~.,data = trainData)
summary(lin_model) 

# testing

testData$pred = predict(lin_model, newdata=testData)

# RMSE for the predicted values
rmse_value = rmse(testData$CustServ.Calls, testData$pred)
#RMSE Value Using Random Sampling  : 1.113052
#RMSE Value Using Stratified Sampling : 1.11244

#rmse for Random Sampling is more than rmse for Stratified Sampling


########################################################################################
########################################################################################
# 2. Now considering the zscalebind and do all the necessary steps and find the best model
########################################################################################
########################################################################################


# Removing the columns:
zscalebind$Day.Charge=NULL
zscalebind$Eve.Charge=NULL
zscalebind$Night.Charge=NULL
zscalebind$Intl.Charge=NULL
zscalebind$Churn=NULL
zscalebind$VMail.Message=NULL
zscalebind$Phone=NULL
zscalebind$Area.Code=NULL
zscalebind$State=NULL


######  EDA ######
#Perform EDA univariant, bi variant and Multivariant analysis and draw inferences from data



######  Sampling ######

## generating train and test data for the linear regression model
## Random sampling
set.seed(153) 
trainrows = sample( nrow(zscalebind), nrow(zscalebind)*0.8)
trainData = zscalebind[trainrows,]
testData = zscalebind[-trainrows,]

## stratified sampling
#install.packages("caTools")
library(caTools)
trainrows=sample.split(zscalebind$CustServ.Calls,SplitRatio = 0.8)
trainData=zscalebind[trainrows,]
testData=zscalebind[!trainrows,]


######  Model Building ######

lin_model=lm(CustServ.Calls~.,data = trainData)
summary(lin_model) 

# testing

testData$pred = predict(lin_model, newdata=testData)

# RMSE for the predicted values
rmse_value = rmse(testData$CustServ.Calls, testData$pred)
#RMSE Value Using Random Sampling  : 1.097055
#RMSE Value Using Stratified Sampling : 1.110488

#rmse for Random Sampling is less than rmse for Stratified Sampling


########################################################################################
########################################################################################

#RMSE Value Using Random Sampling on Min-Max Scaled Data : 1.113052
#RMSE Value Using Stratified Sampling on Min-Max Scaled Data : 1.11244

#RMSE Value Using Random Sampling on Z-Scaled Data : 1.097055
#RMSE Value Using Stratified Sampling on Z-Scaled Data : 1.110488

########################################################################################
########################################################################################

remove(trainData)
remove(testData)
remove(lin_model)


########################################################################################
###################################################
########### Conider Daily.Charges.MV as target
###################################################
########################################################################################

churn_mv2 = read.csv("Churn_MV.csv")

names = colnames(churn_mv2)
charCols=c("Churn","Intl.Plan","VMail.Plan","State","Area.Code","Phone")
numCols=setdiff(names,charCols)
numCols

######  Data Transformation ######

str(churn_mv2)
churn_mv2[,charCols] = lapply(churn_mv2[,charCols], toFactor)
str(churn_mv2)


######  Null Imputation ######

churn_mv2 = churn_mv2[-seq(1,nrow(churn_mv2),by = 2),]
summary(churn_mv2)

# Daily.Charges.MV has some NA's.
# Lets impute them using Linear Regression Model


######  Outlier Treatment ######
boxplot(churn_mv2)

# Columns might have got updated, Let us refresh once
names = colnames(churn_mv2)
charCols=c("Churn","Intl.Plan","VMail.Plan","State","Area.Code","Phone")
numCols=setdiff(names,charCols)
#End

churn_mv2[,numCols]=lapply(churn_mv2[,numCols], Removeoutliers)
summary(churn_mv2)

#########################################################################
#Seperate to Numeric and Category columns before Scaling and Correlation
#########################################################################

churn_num2 = churn_mv2[,numCols]
churn_cat2 = churn_mv2[,charCols]


######  Scaling ######

# The previos Analysis shows us that Z Scaled data with Random Sampling has less RMSE, we will follow that

names(churn_num2)
churn_Zscale2 = as.data.frame(scale(churn_num2[,-10]))
churn_Zscale2$Daily.Charges.MV = churn_num2$Daily.Charges.MV

zscalebind2 = cbind(churn_Zscale2, churn_cat2)
summary(zscalebind2)

remove(churn_Zscale2)

######  Correlation ######

#We know which columns needs to be dropped through Previous analysis

zscalebind2$Day.Charge=NULL
zscalebind2$Eve.Charge=NULL
zscalebind2$Night.Charge=NULL
zscalebind2$Intl.Charge=NULL
zscalebind2$Churn=NULL
zscalebind2$VMail.Message=NULL
zscalebind2$Phone=NULL
zscalebind2$Area.Code=NULL
zscalebind2$State=NULL


######  Sampling ######

## As we need to impute NA's in the target column, we just seperate them as Training and test columns

traindata = zscalebind2[!is.na(zscalebind2$Daily.Charges.MV),]
summary(traindata)
testdata = zscalebind2[is.na(zscalebind2$Daily.Charges.MV),]
summary(testdata)



######  Model Building ######

lin_model=lm(Daily.Charges.MV~.,data = traindata)
summary(lin_model) 

#testing
#The column Daily.Charges.MV has all NA's, We can directly override the column with predicted values.
testdata$Daily.Charges.MV = predict(lin_model, newdata=testdata)



#######################################################################################################
#######################################################################################################
# Make a data set with this Training and Testing data, as we have successfully imputed Daily.Charges.MV
# column. Now, calculate RMSE of this dataset and actual dataset, we will get RMSE for Imputation
# through Linear Regression Model
######################################################################################################
######################################################################################################

# combine traindata and testdata into one dataset

finalchurn = rbind(traindata,testdata)
summary(finalchurn)

#Calculate RMSE between Churn_MV2$Day.Charges (as it is original column of Daily.Charges.MV) and Finalchurn$Daily.Charges.MV

rmsefinal = rmse(churn_mv2$Day.Charge, finalchurn$Daily.Charges.MV)

# rmsefinal : 12.866







































