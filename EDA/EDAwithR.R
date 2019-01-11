####################################################################################
# EDA Basics using R  #############################################################


# EDA is not a formal process with a strict set of rules. More than anything, EDA is a state of mind
####################################################################################


######### Univariant ##############
# Discrete Variable : Bar Charts and Pie Charts
# Continous Variable : Histogram and Box plot

######### Bivariant ##############
# Continous and Discrete : Box Plot
# 2 Continous : Scatter Plot
# 2 Discrete : Bar Chart
##########################


#Section 1 
####################################
# Base package 
# Bar, Pie, Hist and Box plots
###################################

## Data set : Churn

churndata = read.csv("Class Room Codes/Churn.csv")

str(churndata)
summary(churndata)

###########################
# Univariate Analysis
#####################


# On a Discrete Variable
churndata$Churn = as.factor(churndata$Churn)
table(churndata$Churn)
prop.table(table(churndata$Churn)) #Gives Proportion

barplot(table(churndata$Churn))
barplot(prop.table(table(churndata$Churn)))

barplot(table(churndata$Churn),
        col = c('red','green'),
        main = "Bar chart for Churn",
        xlab = "Churn",
        ylab = "Frequency")

table(churndata$VMail.Plan)

barplot(table(churndata$VMail.Plan),
        col = c('white','black'),
        main = 'VMail Plan Bar Plot',
        xlab = 'VMail Plan',
        ylab = 'Frequency'
        )

a = pie(table(churndata$Churn))
a = pie(table(churndata$Churn),
        main = "Pie chart",
        col = c("blue","orange"))


# On a Continous Variable
nrow(churndata[churndata$Day.Mins < 50,])

?hist
hist(churndata$Day.Mins, breaks = 5)
hist(churndata$Day.Mins, 
     breaks = 10,
     col = 'red',
     main = 'Hist for DayMins')


boxplot(churndata$Day.Mins)



###########################
# Bivariate Analysis
#####################

# Two Continous
# plotting Day charges and Day mins. We can see they have high correlation
plot(churndata$Day.Charge, churndata$Day.Mins)
cor(churndata$Day.Mins, churndata$Day.Charge)
plot(churndata$Day.Mins, churndata$Day.Calls)
cor(churndata$Day.Mins, churndata$Day.Calls)

# Continous and Discrete Variable
boxplot(churndata$Day.Mins, churndata$Churn) # plots for both variables

boxplot(churndata$Day.Mins ~ churndata$Churn) # Plots w.r.to Discrete column.

boxplot(churndata$Day.Mins ~ churndata$Churn,
        col = c('red','green'),
        main = 'Box plot')

# Two Discrete
barplot(table(churndata$Intl.Plan, churndata$Churn))

table(churndata$Churn, churndata$Intl.Plan, dnn = c('Churn','Intl.Plan'))

barplot(table(churndata$Churn, churndata$Intl.Plan, dnn = c('Churn','Intl.Plan')),
        col = c('red','white'))



#Section 2: GGPLOT 
####################################
# We have very advances features in this package.

#install.packages("ggplot2")
library(ggplot2)

data("mpg")

##########################
## Data set : Churn  ####

churndata = read.csv("Class Room Codes/Churn.csv")

str(churndata)
summary(churndata)

library(ggplot2)
data(mpg)

mpg = as.data.frame((mpg))

head(mpg)
str(mpg)
mpg$manufacturer = as.factor(mpg$manufacturer)

##### One dimensional plots

##Continous variable

ggplot(data = mpg, aes(cty))+
  geom_histogram(bins = 10)

ggplot(data = mpg, aes(cty))+
  geom_histogram(bins = 10, binwidth = 1)

ggplot(data = mpg, aes(cty))+
  geom_histogram(bins = 10, binwidth = 1) + 
  ggtitle("Histogram using GGPlot 2")

ggplot(data = mpg, aes(cty))+
  geom_histogram(bins = 10, binwidth = 1) + 
  ggtitle("Histogram using GGPlot 2") +
  coord_cartesian(xlim = c(0,100)) # To zoom the axis. So we can check if they are outliers very far. Use ylim for y axis

table(mpg$manufacturer)
ggplot(data = mpg, aes(manufacturer)) + geom_histogram() # throws error as manufac. is not continous
ggplot(data = mpg, aes(manufacturer)) + geom_bar() # bar chart for Discrete variables


ggplot(data = mpg, aes(y=hwy))+
  geom_boxplot()          # Error, another axis has to be present

ggplot(data = mpg, aes(x="Highway",y=hwy))+
  geom_boxplot()

ggplot(data = mpg, aes(1,y=hwy))+
  geom_boxplot()

## Discrete Variable

ggplot(data = mpg, aes(manufacturer)) +
  geom_bar()



##### Two dimensional plots


# 1. two cont. variables 

ggplot(data = mpg, aes(cty,hwy))+
  geom_point()


# 2. One Cont. and One discrete variable

ggplot(mpg, aes(drv,hwy))+
  geom_boxplot()
?mpg

ggplot(mpg, aes(class,hwy)) +
  geom_boxplot()

mpg$cyl = as.factor(mpg$cyl)
ggplot(mpg, aes(cyl, hwy)) + 
  geom_boxplot()

# 3. Two Discrete Variables
ggplot(mpg, aes(fl,fill=drv)) +
  geom_bar()

ggplot(mpg, aes(manufacturer, fill = drv))+
  geom_bar()

ggplot(mpg, aes(manufacturer, fill = drv))+
  geom_bar(position = 'dodge')

ggplot(mpg, aes(manufacturer, fill = drv))+
  geom_bar(position = 'fill')


ggplot(mpg, aes(class, fill = cyl)) + geom_bar()

ggplot(mpg, aes(class, fill = drv)) + geom_bar()

ggplot(mpg, aes(class, fill = drv)) + geom_bar(position = 'dodge')

ggplot(mpg, aes(manufacturer, fill = class)) + geom_bar()


### multidimensional plots 

ggplot(mpg, aes(cty, hwy, size = displ)) + 
  geom_point()

ggplot(mpg, aes(cty, hwy, col = drv, size = displ)) + 
  geom_point()

ggplot(mpg,aes(cty, hwy, col = class, shape = drv, size = displ)) + 
  geom_point()


mpg$cyl = as.integer(mpg$cyl)

ggplot(mpg,aes(cty, hwy, col = class, shape = drv, size = cyl)) + 
  geom_point()+
  facet_grid(year~fl)

ggplot(mpg,aes(cty, hwy, col = class, shape = drv, size = cyl)) + 
  geom_point()+
  facet_grid(.~year)

ggplot(mpg,aes(cty)) + 
  geom_freqpoly(aes(col = class), bins = 20)
  


### Add text to chart
str(mpg)

ggplot(mpg, aes(class)) + 
  geom_bar() +
  geom_text(aes(label = ..count..), stat = 'count')


ggplot(mpg, aes(class)) + 
  geom_bar() +
  geom_text(aes(label = ..count..), stat = 'count', position = 'stack')

ggplot(mpg, aes(class)) + 
  geom_bar() +
  geom_text(aes(label = ..count..), stat = 'count', position = 'identity')


##################
# For Preprocessing basics, refer Class room codes too and below link
# https://r4ds.had.co.nz/exploratory-data-analysis.html#introduction-3

























