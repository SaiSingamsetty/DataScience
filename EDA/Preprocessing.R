credit = read.csv("C:/Users/phsivale/Downloads/credit.csv")
##Removing duplicates if any

name = c("Anne","Anne", "Pete", "Cath", "Cath", "Cath")
age = c(28,28,30,25,29,35)
child <- c(FALSE,FALSE,TRUE,FALSE,TRUE,TRUE)
df2 <- data.frame(name,age,child)
unique(df2)
df2 <- unique(df2)

### Scaling ### Minmax Scaling [0,1]
fnScaling = function(x){
  return((x-min(x))/(max(x)-min(x)))
}
summary(credit$amount)

### Z Score Scaling
fnScaling = function(x){
  return((x-mean(x))/sd(x))
}

credit$scaled_amount_zscore  = fnScaling(credit$amount)
summary(credit)

### Cat to Numeric
str(credit)
credit$purpose
credit2 = credit[,c('amount','purpose','employment_duration')]

library(dummies)
credit_dmmies = dummy.data.frame(credit2)
# credit_dmmies$purpose = credit$purpose

### If k levels use only k-1 columns. Degrees of freedom
credit_dmmies = credit_dmmies[,-c(2)]
names(credit_dmmies)

### Ordinal Encoding
credit2$employment_duration_ordinal = 
  ifelse(credit2$employment_duration=='unemployed',0,
       ifelse(credit2$employment_duration=='< 1 year',1,
              ifelse(credit2$employment_duration=='1 - 4 years',2,
                     ifelse(credit2$employment_duration=='4 - 7 years',3,4))))
