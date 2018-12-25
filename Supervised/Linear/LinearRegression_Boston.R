library(MASS)
data(Boston)
?Boston
Boston
summary(Boston$medv)

##log or sqrt transformation
hist(Boston$medv)
hist(log(Boston$medv))
hist(sqrt(Boston$medv))
summary(log(Boston$medv))
summary(sqrt(Boston$medv))
Boston$rad = as.factor(Boston$rad)


Boston$medv_sqrt = sqrt(Boston$medv)
#### Simple Linear Regression with Lstat

plot(Boston$lstat,Boston$medv)
cor(Boston$lstat,Boston$medv)

# abline(mod1)

plot(Boston$lstat,Boston$medv_sqrt)
cor(Boston$lstat,Boston$medv_sqrt)

Boston$lstat_sqrt = sqrt(Boston$lstat)
#### Handling Outliers

hist(Boston$medv_sqrt)
summary(Boston$medv_sqrt)

mean(Boston$medv_sqrt) + 3 * sd(Boston$medv_sqrt)
mean(Boston$medv_sqrt) - 3 * sd(Boston$medv_sqrt)

hist(Boston$crim)
hist(Boston$zn)
hist(Boston$chas)
hist(Boston$tax)
hist(Boston$ptratio)
hist(Boston$black)

### train test split
set.seed(123)
# sample(rows,10)
rows= 1:nrow(Boston)
train_rows = sample(rows,round(length(rows)*0.7))
test_rows = rows[-train_rows]

train_data = Boston[train_rows,]
test_data = Boston[test_rows,]


### Model 1
mod1 = lm(medv~lstat,data=train_data)
mod1 = lm(medv_sqrt~lstat,data=train_data)
plot(train_data$lstat,train_data$medv)
plot(train_data$lstat,train_data$medv_sqrt)
summary(mod1)
abline(mod1)

mod2 = lm(medv_sqrt~lstat,data=train_data)
summary(mod2)
abline(mod2)

plot(mod2)

hist(train_data$lstat)
hist(sqrt(train_data$lstat))
train_data$lstat_sqrt = sqrt(train_data$lstat)
### Model 2
mod3 = lm(medv_sqrt~lstat_sqrt,data=train_data)
summary(mod3)
plot(mod3)

abline(mod2)

mod4 = lm(medv_sqrt~.-lstat-medv-age-indus,data=train_data)
summary(mod4)

#### Outliers
mean(Boston$medv_sqrt) + 3*sd(Boston$medv_sqrt)
mean(Boston$medv_sqrt) - 3*sd(Boston$medv_sqrt)

Boston = Boston[Boston$med_sqrt < 7 & Boston$med_sqrt > 2, ]


###indus

Boston$indus_cat = ifelse(Boston$indus > 17, 'High','Normal')
Boston$indus_cat = as.factor(Boston$indus_cat)



mod1 = lm(medv~ lstat+rad,data=Boston)
summary(mod1)


mod3 = lm(medv_sqrt ~.-medv-age-indus, data=train_data)
summary(mod3)

mod2 = lm(medv_sqrt ~ lstat+ black+ crim, data=Boston)
summary(mod2)

mod3 = lm(medv_sqrt ~ .-medv-indus-age-lstat , data=Boston)
summary(mod3)

summary(mod3$residuals)
plot(mod3)

View(cor(Boston[,-c(3,7,14,15)]))

hist(log(Boston$medv))
summary(log(Boston$medv))
hist(sqrt(Boston$medv))
summary(sqrt(Boston$medv))

Boston$medv_sqrt =  sqrt(Boston$medv)

### train and test
rows = 1:nrow(Boston)
trainRows = sample(rows,round(0.7*nrow(Boston)))

trainData = Boston[trainRows,]
testData = Boston[-trainRows,]

## Final model

finalModel = lm(medv_sqrt ~ .-medv-indus-age-lstat , data=trainData)
summary(finalModel)

### Preds
preds = predict(finalModel,testData)
preds = preds**2

### RMSE
sqrt(mean((testData$medv - preds)**2))
step()

