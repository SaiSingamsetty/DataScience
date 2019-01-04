#https://www.youtube.com/watch?v=MoBw5PiW56k
library(rpart)
library(rpart.plot)

library(ggplot2)
data("msleep")
str(msleep)
mydata = msleep[,c(3,6,10,11)]
str(mydata)

##################################

# CART : Classification and Regression Tree

# Regression tree
# Target : Sleep_total
##################################

Rtree1 = rpart(sleep_total ~ ., data = mydata, method = "anova")
Rtree1

plot(Rtree1)
text(Rtree1)  # Not proper, Use Rpart.plot

rpart.plot(Rtree1, type = 3, digits = 3, fallen.leaves = TRUE)


# The sleep total obtained will be the Average of the Sub groups formed at those nodes.


preds = predict(Rtree1, mydata)
mydata$preds = preds

mydata$Err = mydata$sleep_total - mydata$preds





