# Referred theory from 
# https://trainings.analyticsvidhya.com/courses/course-v1:AnalyticsVidhya+Python-Final-Jan-Feb+Python-Session-1/courseware/73167b5cca8447dfa535a80d3961dc61/821ac77ab0104820bfa494cb55b237d9/?activate_block_id=block-v1%3AAnalyticsVidhya%2BPython-Final-Jan-Feb%2BPython-Session-1%2Btype%40sequential%2Bblock%40821ac77ab0104820bfa494cb55b237d9



#########################################
##############k-Means clustering   ####
########################################


#myecomdata = read.csv('EcommerceData.csv')

datakmeans = read.csv('universalBank.csv')

# Remove unncessary columns
#1 Go
datakmeans$ID = NULL

#Outliers
#1 GO
# I am not removing any outliers right now as those values may also form a cluster. We can check and remove outliers in the second GO if necessary


#Scaling
# It is important to bring all variables into same dimensions. 
# As there are values between 0 to 1, we use min max scaling only which make all values between [-1,1]

minmaxscale = function(x){
  return ((x - min(x))/(max(x)-min(x)))
}

i = NULL
for(i in 1:ncol(datakmeans))
{
  datakmeans[,i] = minmaxscale(datakmeans[,i])
}

#or using lapply fucntion
#datakmeans = as.data.frame(lapply(datakmeans,MinMaxScale))

# Missing Values
str(datakmeans)
summary(datakmeans)
# There are no missing values here.


# Build Model
#First find ideal no of clusters to be made using elbow plot.
wssbybss = c()
for( i in 2:15){
  kmodel = kmeans(datakmeans, i)
  wssbybss = c(wssbybss, mean(kmodel$withinss)/kmodel$betweenss)
  
}

#elbow plot
plot(2:15,wssbybss, type = 'l') #Cluster can be 7

#Now built the ideal model with ideal no of clusters we got
kmodel = kmeans(datakmeans, 7)


# Centers of each variable for 7 clusters.
kmodel$centers

# make a column in the dataset with Cluster no for each entry
datakmeans$ClusterNo = kmodel$cluster

#Other useful metrics
#It is within Cluster sum of squares. It should be as lower as possible for homopgenity within clusters.
kmodel$withinss

#It is between Clusters sum of squares.this ratio, to be as higher as possible, since we would like to have heterogenous clusters.
kmodel$betweenss





#########################################
###########  Hierarchial Clustering  ###
########################################
data("mtcars")
datahc = mtcars

summary(datahc)

# Scaling
fnScaling = function(x){
  return((x-min(x))/(max(x)-min(x)))
}

for(i in 1:ncol(datahc)){
  datahc[,i] = fnScaling(datahc[,i])
}

summary(datahc)

#Missing Values
#No NAs in the data

# Distance Matrix
distancematrix = dist((datahc),method = 'euclidean')

View(as.matrix(distancematrix))


#Build Model
hmodel = hclust(distancematrix)


#Plotting Cluster Dendogram
plot(hmodel)


# Cut the dendogram into Clusters
clustergroups = cutree(hmodel, h = 1.5)
clustergroups
table(clustergroups)

#Assign Cluster number to Original dataset
datahc$Clusterno = clustergroups


##check
test = datahc[datahc$Clusterno==1,]




#########################################
###########   Association  ###
########################################
















#########################################
###########   Clustering  ###
########################################
# https://www.kaggle.com/fabiendaniel/customer-segmentation/notebook

myecomdata = read.csv('EcommerceData.csv')

str(myecomdata)
summary(myecomdata)

head(myecomdata)

myecomdata[myecomdata$InvoiceNo == 536365, ]
myecomdata[myecomdata2$CustomerID == 17850, ]

sum(is.na(myecomdata3$Quantity))
myecomdata2 = myecomdata[!is.na(myecomdata$CustomerID),]

# Remove unnecessary columns
myecomdata2$Description = NULL

#data type conversion
str(myecomdata2)


#create dummies for Country column
library(dummies)
myecomdata2 = dummy.data.frame(myecomdata2)


for(i in 1:ncol(myecomdata2)){
  myecomdata2[,i] = minmaxscale(myecomdata2[,i])
}





















