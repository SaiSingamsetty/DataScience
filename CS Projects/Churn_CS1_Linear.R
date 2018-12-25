setwd('D:/Learnings/DataScience/ML')
churn = read.csv('Churn_MV.csv')

## Data transformation. required types to FACTOR variables based on column definition
is.factor(churn$Churn)
class(churn$Intl.Calls)
table(churn$Intl.Calls)

churn$Churn = as.factor(churn$Churn)
churn$State = as.factor(churn$State)
churn$Area.Code = as.factor(churn$Area.Code)
churn$VMail.Plan = as.factor(churn$VMail.Plan)
churn$Intl.Plan = as.factor(churn$Intl.Plan)
churn$Phone = as.factor(churn$Phone)

#Checking for NA in all columns: Summary will display NA's count
summary(churn)
# there are 3333 NA in all cols except DailyCharges.MV (3383)

#1
#alternate rows are NA, try to remove using this
churn2 = churn[seq(1,nrow(churn),by = 2),]
summary(churn2)
#all odd no rows are NA's. Just remove from original dataset
churn2 = churn[-seq(1,nrow(churn),by = 2),]
summary(churn2)

#2
# Check if the target variable is NA, if it is then remove that entire row
Churn3 = churn[!is.na(churn$Churn),]


## DailyCharges.MV has extra NA's
#We have to impute that column using Mean or Median

#Now we have to find RMSE for meanrow and medianrow with actual row. The actual row is day.charges, if you observe. DailyChargesMv is copy of DayCharges with some NA's in it. Wantedly created this row dailyChragesMV to understand the imputation

Churn3$Daily.Charges.MV.Mean = ifelse(is.na(Churn3$Daily.Charges.MV), mean(Churn3$Daily.Charges.MV, na.rm = T), Churn3$Daily.Charges.MV)
Churn3$Daily.Charges.MV.Median = ifelse(is.na(Churn3$Daily.Charges.MV), median(Churn3$Daily.Charges.MV, na.rm = T), Churn3$Daily.Charges.MV)

#RMSE with mean row
Churn3$RMSE.Mean = (Churn3$Daily.Charges.MV.Mean - Churn3$Day.Charge)
Churn3$RMSE.Meansq = Churn3$RMSE.Mean ** 2
rmsemean = sqrt(mean(Churn3$RMSE.Meansq))

#RMSE with median row
Churn3$RMSE.Median = (Churn3$Daily.Charges.MV.Median - Churn3$Day.Charge)
Churn3$RMSE.Mediansq = Churn3$RMSE.Median ** 2
rmsemeadian = sqrt(mean(Churn3$RMSE.Mediansq))


#Remove Outliers now from the data.
# two approaches: 1. Equate it to viscous lines. 2. Remove those rows

#boxplot for all columns. 
# Check the outliers by plotting box plot for each column. Then remove the upper outliers by equating to the top value (Q3+1.5IQR) and (Q1-1.5IQR) for below outliers
boxplot(Churn3)

#1 equate to viscous lines
boxplot(Churn3$Account.Length)
x = summary(Churn3$Account.Length)
top=x[5]+(1.5*IQR(Churn3$Account.Length)) #top 
bottom=x[2]-(1.5*IQR(Churn3$Account.Length))

Churn3$Account.LengthO = ifelse(Churn3$Account.Length > top, top, Churn3$Account.Length)
boxplot(Churn3$Account.LengthO)


boxplot(Churn3$Day.Mins)
x = summary(Churn3$Day.Mins)
top=x[5]+(1.5*IQR(Churn3$Day.Mins)) #top 
bottom=x[2]-(1.5*IQR(Churn3$Day.Mins))

Churn3$Day.MinsO = ifelse(Churn3$Day.Mins > top, top, Churn3$Day.Mins)
Churn3$Day.MinsO = ifelse(Churn3$Day.MinsO < bottom, bottom, Churn3$Day.MinsO)
boxplot(Churn3$Day.MinsO)

#2 Remove those entire rows having Outliers
boxplot(Churn3$Eve.Mins)
x = summary(Churn3$Eve.Mins)
top=x[5]+(1.5*IQR(Churn3$Eve.Mins)) 
bottom=x[2]-(1.5*IQR(Churn3$Eve.Mins))

churn4 = Churn3[!(Churn3$Eve.Mins > top),]
churn4 = churn4[!(churn4$Eve.Mins < bottom),]
boxplot(churn4$Eve.Mins)

### Scaling
#Why Scaling ? To bring down all dimensions into one dimension. One column has max of 1000, other can have max of 10. We have to plot it in same plan for Regression model. So bring all cols to same plane
#Churn3 is the latest. Use that

namesofChurn3 = names(Churn3)
is.numeric(Churn3$VMail.Plan)

Churn3.Numeric = Churn3[,unlist(lapply(Churn3, is.numeric))]
Churn3.Categoric = Churn3[,!unlist(lapply(Churn3, is.numeric))]

?lapply
lapply(Churn3, is.numeric)
!unlist(lapply(Churn3, is.numeric))


## Min Max Scaling
MinMaxScale <- function(x)
{
  return((x- min(x)) /(max(x)-min(x)))
}

Churn3.Numeric$Account.Length
MinMaxScale(Churn3.Numeric$Account.Length)

Churn3.Numeric.MinMax = as.data.frame(lapply(Churn3.Numeric,MinMaxScale))

?scale
?lapply

## Z Scaling
Churn3.Numeric.ZScale = as.data.frame(scale(Churn3.Numeric))


## Combine back the MinMax scaled and Z Scaled with Categoric dataset.
#MinMax
Churn4.MinMax = cbind(Churn3.Numeric.MinMax,Churn3.Categoric)
# As DailyChargesMv has some NA's, we replaced NA's with mean and median in diff cols, ignore that col

#ZScaling
Churn4.ZSclaed = cbind(Churn3.Numeric.ZScale,Churn3.Categoric)


#### Correlation
#Numeric columns - correlation done by Cor
?cor
View(cor(Churn3.Numeric.ZScale))
#install.packages('corrplot')
library(corrplot)

?corrplot
corrplot(cor(Churn3.Numeric.ZScale), 'circle')


# Categoric Columns - done by chisquare test
?chisq.test
# plot for all possible columns and check the p value
chisq.test(Churn3.Categoric$Churn,Churn3.Categoric$Intl.Plan)
chisq.test(Churn3.Categoric$Churn,Churn3.Categoric$VMail.Plan)

chisq.test(Churn3.Categoric$Intl.Plan,Churn3.Categoric$VMail.Plan)



# numeric and Categoric - done by ANOVA
p1 = aov(Churn4.MinMax$Account.Length ~ Churn4.MinMax$Churn)
p2 = aov(Churn4.MinMax$Account.Length ~ Churn4.MinMax$VMail.Plan)
p3 = aov(Churn4.MinMax$VMail.Message ~ Churn4.MinMax$VMail.Plan)
summary(aov(Churn4.MinMax$Intl.Charge ~ Churn4.MinMax$Intl.Plan))
summary(p1)

######## EDA #######
library(ggplot2)

## Univariant
Churn3$CustServ.Calls
ggplot(data = Churn3, aes(CustServ.Calls)) +
  geom_histogram(bins = 30)
  
## Bivariant
Churn4.MinMax$Account.Length

ggplot(Churn4.MinMax, aes(x=Churn, y=Account.Length)) + 
  geom_boxplot()

table(Churn4.MinMax$VMail.Plan)

ggplot(Churn3,aes(x=VMail.Message,fill=VMail.Plan)) + 
  geom_bar(position = 'fill')

ggplot(Churn3, aes(CustServ.Calls, Day.Calls)) + 
  geom_point()


######################################
# removing unwanted columns from data set (min Max: Churn4.MinMax)
# Considering dailychargesMV mean as it gives less RMSE, remove Median column
# from chi square test we can remove Churn 
names(Churn4.MinMax)
x = c(1,3:6,18:22,24,25)
Churn5MinMax = Churn4.MinMax[-x]

##
names(Churn4.ZSclaed)
x = c(1,3:6,18:22,24,25)
Churn5ZSclaed = Churn4.ZSclaed[-x]

names(Churn5ZSclaed)
y = c(15:19)
Churn5temp = Churn5ZSclaed[-y]

corrplot(cor(Churn5temp), 'circle')



### Churn5MinMax and Churn5ZSclaed are columns with least correlation
names(Churn5MinMaxf)
names(Churn5ZSclaed)

names(Churn5MinMaxf)[13] = 'CustServ.Calls'
########################Linear regression####################
## for Churn5MinMax
## Target is CustServCalls
#remove daily charges MV columns, unnecessary categorical
z = c(2,4,5,16:18)
Churn5MinMaxf = Churn5MinMax[-z]
Churn5MinMaxf = cbind(Churn5MinMaxf,Churn3.Numeric$CustServ.Calls)
#train and test split
set.seed(120)

rows = sample( nrow(Churn5MinMaxf), nrow(Churn5MinMaxf)*0.8)

train = Churn5MinMaxf[rows,]
test = Churn5MinMaxf[-rows,]

## model 

lm_minmax = lm( CustServ.Calls ~ . , data=train )

summary(lm_minmax)

test$predicted = predict(lm_minmax, newdata=test )

#rmse
test$error = test$CustServ.Calls - test$predicted

test$error_sq = test$error ** 2

rmse = sqrt(mean(test$error_sq))
rmse  #1.38153

## for Churn5ZSclaed
## Target is CustServCalls
#remove daily charges MV columns, unnecessary categorical
z = c(4,5,16:18)
Churn5ZSclaedf = Churn5ZSclaed[-z]

#train and test split
set.seed(143)

rows = sample( nrow(Churn5ZSclaedf), nrow(Churn5ZSclaedf)*0.8)

train = Churn5ZSclaedf[rows,]
test = Churn5ZSclaedf[-rows,]

## model 

lm_zscale = lm( CustServ.Calls ~ . , data=train )

summary(lm_zscale)

test$predicted = predict(lm_zscale, newdata=test )

#rmse
test$error = test$CustServ.Calls - test$predicted

test$error_sq = test$error ** 2

rmse = sqrt(mean(test$error_sq))
rmse #1.025511


#Now I got rmse less for ZScaled data. Now make Daily Charges MV as target and
#build model and calculate RMSE.














