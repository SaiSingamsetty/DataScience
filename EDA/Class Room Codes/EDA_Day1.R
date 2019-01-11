#### EDA 

library(ggplot2)

data(mpg)

setwd("C:/Users/phsivale/Documents/Trainings/")

cust_data = read.csv("Logistic Regression/Churn.csv")


str(cust_data)


### Univariate Analysis
cust_data$Churn = as.factor(cust_data$Churn)

table(cust_data$Churn)
prop.table(table(cust_data$Churn))

## Univariate on discrete variable
barplot(table(cust_data$Churn)) ## actual counts
barplot(prop.table(table(cust_data$Churn)))## proportions

## Univariate on Continuous Variable

summary(cust_data$Day.Mins)
hist(cust_data$Day.Mins,breaks = 5)
hist(cust_data$Day.Mins,breaks = 25)
hist(cust_data$Day.Mins,breaks = 50)

boxplot(cust_data$Day.Mins)

###

plot(cust_data$Day.Mins, cust_data$Day.Charge)
cor(cust_data$Day.Mins, cust_data$Day.Charge)
