data1 = read.csv("universalBank.csv")
data1$ID = NULL

data1$ZIP.Code= as.factor(data1$ZIP.Code)
data1$Personal.Loan = as.factor(data1$Personal.Loan)
summary(data1)

unique(data1$ZIP.Code)
data1$ZIP.Code = NULL
###### Handling Exp
sum(data1$Experience < 0) #Experience has negative values.
#As we get high correlation between Age and Experience, we can drop this column at that time


#### Correlation
library(corrplot)
corrplot(cor(data1[,c(1:7)]),method='number')

### dropping as correlation is too high
data1$Experience = NULL

### Scaling
# we have to use MinMax scaling here as there are already somme rows which are scaled in [0,1]
fnScaling = function(x){
  return((x-min(x))/(max(x)-min(x)))
}

for(i in 1:ncol(data1)){
  if(names(data1)[i] %in% c('Personal.Loan','Online',
                            'CD.Account','Securities.Account','CreditCard')){
    data1[,i] = data1[,i]
  }
  else{
    data1[,i] = fnScaling(data1[,i])  
  }
  
}

summary(data1)

#Anyways it is less important, we will engineer this column by converting into a categorical column and see if it has impact
data1$Mortgage = ifelse(data1$Mortgage>0,1,0)
### traintest split
nrows = c(1:nrow(data1))
trainRows = sample(nrows, 3500)

trainData = data1[trainRows,]
testData = data1[-trainRows,]

hist(data1$Mortgage)

## Model
mod1 =glm(Personal.Loan~.-Age,data=trainData,
          family=binomial(link='logit'))
summary(mod1)

## preds
preds = predict(mod1,testData[,-c(7)],type='response')
preds = ifelse(preds>=0.09,1,0)
table(testData$Personal.Loan, preds,dnn=c('acts','preds'))


## ROC Curver
library(ROCR)
### add the ROC graph of credit_model1 on the same plot 
pred = prediction(preds , testData$Personal.Loan)
perf= performance(pred, "tpr","fpr")
# plot(perf,colorize = T)

plot(perf, colorize=T, print.cutoffs.at=seq(0,1,by=0.1), 
     text.adj=c(1.2,1.2), avg="threshold", lwd=3,
     main= "ROC")