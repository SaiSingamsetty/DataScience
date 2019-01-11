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
barplot(table(cust_data$Churn),
        col = c('red','green'),
        main = 'Bar Chart for Churn',
        xlab = 'Churn',
        ylab = 'Frequency') ## actual counts

barplot(prop.table(table(cust_data$Churn)))## proportions

## Univariate on Continuous Variable

summary(cust_data$Day.Mins)
hist(cust_data$Day.Mins,breaks = 5)
hist(cust_data$Day.Mins,breaks = 25)
hist(cust_data$Day.Mins,breaks = 50,
     col='red',
     main = 'Histogram of Day Mins')

boxplot(cust_data$Day.Mins)

###
plot(cust_data$Day.Mins, cust_data$Day.Calls)
cor(cust_data$Day.Mins, cust_data$Day.Calls)
plot(cust_data$Day.Mins, cust_data$Day.Charge)
cor(cust_data$Day.Mins, cust_data$Day.Charge)

### cont. variables 

hist(cust_data$Day.Mins, breaks = 10) ## breaks will decide the number of bars 

boxplot(cust_data$Day.Mins)

summary(cust_data$Day.Mins)

### one discrete variable 

cust_data$Churn = as.factor(cust_data$Churn)

barplot(table(cust_data$Churn),
        col = c("blue", "orange"), 
        main="Bar Chart of the Churn Distribution",
        xlab = 'Churn Flag',
        ylab = 'Count')

a =  pie(table(cust_data$Churn), 
         col = c("blue", "orange"), 
         main = "Pie of Customer Churn")

getwd()

ggsave(a, "pichart.jpg")

### two dimensional 

str(cust_data)

plot(cust_data$Day.Mins, cust_data$Night.Mins)

plot(cust_data$Day.Mins, cust_data$Day.Charge)

cor(cust_data$Day.Mins, cust_data$Night.Mins)

cor(cust_data$Day.Mins, cust_data$Day.Charge)

### Cont., discrete variable 
boxplot(cust_data$Day.Mins, cust_data$Day.Calls) ## PLots two 

boxplot(cust_data$Day.Mins[cust_data$Churn=='0'], cust_data$Day.Mins[cust_data$Churn=='1'])
boxplot(cust_data$Day.Mins ~ cust_data$Churn)

boxplot(cust_data$Day.Mins ~ cust_data$Churn, 
        col = c("red","green"), 
        main = "Distribution of Day usage b/w Churn and Non-Churn customers")

### two Disc. variables 
barplot(table(cust_data$Churn,cust_data$Intl.Plan))

table(cust_data$Churn,cust_data$Intl.Plan, dnn=c('Churn','IntlPlan'))

barplot(table(cust_data$Churn,cust_data$Intl.Plan, dnn=c('Churn','IntlPlan')),
        col = c('red','blue'))
cust_data$Intl.Plan = as.factor(cust_data$Intl.Plan)

table(cust_data$Churn, cust_data$Intl.Plan, dnn=c('Churn','Intl Plan'))

barplot(table(cust_data$Churn, cust_data$Intl.Plan, dnn=c('Churn','Intl Plan')), 
        col=c('red','blue'))

install.packages("ggplot2")
library(ggplot2)

## one dimensional plots 

## 1. Cont. variable 

data(mpg)

mpg = as.data.frame((mpg))

head(mpg)


ggplot(data=mpg, aes(cty))+
  geom_histogram(bins = 10)

ggplot(data=mpg, aes(x="Highway",y=hwy))+
  geom_boxplot()

ggplot(data=mpg, aes(manufacturer))+
  geom_bar()

## 1. Histogram 

ggplot(mpg , aes(hwy) ) + 
  geom_histogram(bins = 7)

ggplot(cust_data, aes(Day.Mins)) + 
  geom_histogram(binwidth = 30)

## 2. Boxplot 

ggplot(mpg, aes(1,hwy)) + geom_boxplot()

### two dimensional 

# 1. two cont. variables 

ggplot(mpg, aes(cty, hwy)) + 
  geom_point()

## 2. one cont. and one discrete variable 

ggplot(mpg, aes(x=drv, y=hwy)) + 
  geom_boxplot()

ggplot(mpg, aes(class, hwy)) + geom_boxplot()

ggplot(mpg,aes(x=fl,fill=drv)) + geom_bar()

ggplot(mpg,aes(x=manufacturer,fill=drv)) + 
  geom_bar(position = 'dodge')

ggplot(mpg,aes(x=manufacturer,fill=drv)) + 
  geom_bar(position = 'fill')


mpg$cyl_s = as.factor(mpg$cyl)

ggplot(mpg, aes(cyl_s, hwy)) + geom_boxplot()


## two factor variables 
ggplot(mpg, aes(class, fill = cyl_s)) + geom_bar()

ggplot(mpg, aes(class, fill = drv)) + geom_bar()

ggplot(mpg, aes(class, fill = drv)) + geom_bar(position = 'dodge')

ggplot(mpg, aes(manufacturer, fill = class)) + geom_bar()

### multidimensional plots 
data
## First start with a scatterplot 
ggplot(mpg, aes(cty, hwy, col=drv, size=displ)) + geom_point()

head(mpg)
ggplot(mpg,aes(cty, hwy, col = class, shape = drv, size = displ)) + geom_point()

### 
a = ggplot(mpg,aes(cty, hwy, col = class, shape = drv, size = cyl)) + 
  geom_point()


ggplot(mpg,aes(cty, hwy, col = class, shape = drv, size = cyl)) + 
  geom_point()+
  facet_grid(year~fl)
### facets options 

mpg$year = as.factor(mpg$year)

a + facet_grid( year ~ .)
a + facet_grid( . ~ year)

## facets with more than one variable 

a + facet_grid(year ~ fl)


### cust_data 

ggplot(cust_data, aes(Day.Mins, Night.Mins, col = Churn)) + geom_point()
