library(MASS)
data("Boston")
bostondata = Boston
?Boston
View(bostondata)
str(bostondata)


# checking Correlation
View(cor(bostondata))
library(corrplot)
corrplot(cor(bostondata), 'number')


#Outlier removal (not in the first go as the outliers itself can create a cluster)
boxplot(bostondata)
boxplot(bostondata$crim)

x = summary(bostondata$crim)
top=x[5]+(1.5*IQR(bostondata$crim)) #top 
bottom=x[2]-(1.5*IQR(bostondata$crim))

bostondata$crim = ifelse(bostondata$crim > top, top, bostondata$crim)

boxplot(bostondata$zn)
x = summary(bostondata$zn)
top=x[5]+(1.5*IQR(bostondata$zn)) #top 
bottom=x[2]-(1.5*IQR(bostondata$zn))

bostondata$zn = ifelse(bostondata$zn > top, top, bostondata$zn)

boxplot(bostondata$black)
x = summary(bostondata$black)
top=x[5]+(1.5*IQR(bostondata$black)) #top 
bottom=x[2]-(1.5*IQR(bostondata$black))

bostondata$black = ifelse(bostondata$black < bottom, bottom, bostondata$black)

#bostondata$black = Boston$black

## Scaling

MinMaxScale <- function(x)
{
  return((x- min(x)) /(max(x)-min(x)))
}

bostondata = as.data.frame(lapply(bostondata,MinMaxScale))
summary(bostondata)

# Clustering
ss = c()
ss1 = c()
for (i in 2:15) {
  clust = kmeans(x = bostondata, centers = i)
  ss = c(ss, mean(clust$withinss)/clust$betweenss)
  ss1[i-1] = mean(clust$withinss)/clust$betweenss # another way
}
ss
ss1

plot(2:15,ss, type = 'l')
plot(2:15,ss1, type = 'l')

# The best Cluster value is 5 

clust = kmeans(x = bostondata, centers = 6)

clust$centers

clust$cluster

bostondata$Cluster = clust$cluster
?Bostons








