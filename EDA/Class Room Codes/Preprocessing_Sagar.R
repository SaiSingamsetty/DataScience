library("titanic")
str(titanic_train)

### find out the number of missing values 
is.na(1)
is.na(NA)

a = c(10,20,30,NA,NA,34)
is.na(a)
sum(is.na(a))
table(is.na(a))
nrow(titanic_train)

table(is.na(titanic_train$Age))
sum(is.na(titanic_train$Age))

### missing values in entire dataframe 
sum(is.na(titanic_train))

### impute using mean or median 
age_mean = mean(titanic_train$Age, na.rm = T)
## replacing with mean 
titanic_train$Age[is.na(titanic_train$Age)] = age_mean
## replacing with median 
titanic_train$Age[is.na(titanic_train$Age)] = median(titanic_train$Age)

### total missing values in the entire dataframe
sum(is.na(titanic_train$Age))

### placeholder value 

## replace all the missing values with a placeholder value 

titanic_train[ is.na(titanic_train)] = -1

### ordinal variables from continiuos variables 

age = 10 

age_group =''

if( age <=25 ){
  age_group = '0-25'
}else if( age > 25 & age <=35){
  age_group = '26-35'
}else if(age > 35 & age <=45){
  age_group = '36-45'
}else age_group ='45+'

age_group


age = c( 24, 29, 38, 44, 51)
age_group=''

for( i in 1:length(a)){
  
  if( age[i] <=25 ){
    age_group[i] = '0-25'
  }else if( age[i] > 25 & age[i] <=35){
    age_group[i] = '26-35'
  }else if(age[i] > 35 & age[i] <=45){
    age_group[i] = '36-45'
  }else age_group[i] ='45+'
  
}
  age_group
  
for( i in 1:nrow(titanic_train)){
  if( titanic_train$Age[i] <=25 ){
    titanic_train$age_group[i] = '0-25'
  }else if( titanic_train$Age[i] > 25 & titanic_train$Age[i] <=35){
    titanic_train$age_group[i] = '26-35'
  }else if(titanic_train$Age[i] > 35 & titanic_train$Age[i] <=45){
    titanic_train$age_group[i] = '36-45'
  }else titanic_train$age_group[i] ='45+'
}
  
head(titanic_train)


### Normalization 

###  min max normalization
minmax = function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

a = c( 10, 20, 30, 40, 50)

minmax(a)

b = c(1000, 3000, 6000, 10000)

minmax(b)

## standard normaization ( z-scores)

b = scale(a)
b
mean(b)
sd(b)


head(titanic_train)

### 

head(iris)
head(mtcars)

### standard normalization function 
zscore = function(x) { 
  return ((x - mean(x)) / (sd(x)))
}

zscore(a)


### remove all observations where there re missing values 

sum(is.na(titanic_train))

titanic_train = na.omit(titanic_train)

## remove outliers 

remove_outliers <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
  y = na.omit(y)
}

a = c( 10, 100, 110, 120, 130,140, 500)

b = remove_outliers(a)

b

### transformations 

setwd("D:/AP/linear")

insurance = read.csv("insurance.csv")
head(insurance)


##### distribution of charges variable 

hist(insurance$charges)

### apply log transformation 

insurance$log_charges = log(insurance$charges)

hist(insurance$log_charges)

insurance$charges_sqrt = sqrt(insurance$charges)

hist(insurance$charges_sqrt)

insurance$charges_inv = 1/(insurance$charges)

hist(insurance$charges_inv)
#######################
age = c( 25, 26, 27, 28, 29, 30)
gender = c( "M","F", "M","F","M","F")
edu = c( "A","B","C", "A","B","C")

df = data.frame(age, gender, edu)

library(dummies)

df_dummy = dummy.data.frame(df)

head(df_dummy)
