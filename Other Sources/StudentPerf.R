studentsdata = read.csv('StudentsPerformance.csv')

min(studentsdata$math.score)
table(studentsdata$math.score)
studentsdata$math.score = ifelse(studentsdata$math.score < 35, 'F', ifelse(studentsdata$math.score < 65,'C',ifelse(studentsdata$math.score < 80, 'B',ifelse(studentsdata$math.score <95,'A','A+'))))
studentsdata$reading.score = ifelse(studentsdata$reading.score < 35, 'F', ifelse(studentsdata$reading.score < 65,'C',ifelse(studentsdata$reading.score < 80, 'B',ifelse(studentsdata$reading.score <95,'A','A+'))))
studentsdata$writing.score = ifelse(studentsdata$writing.score < 35, 'F', ifelse(studentsdata$writing.score < 65,'C',ifelse(studentsdata$writing.score < 80, 'B',ifelse(studentsdata$writing.score <95,'A','A+'))))

names(studentsdata)
x = as.data.frame(table(studentsdata$math.score))
str(studentsdata)
studentsdata$math.score = as.factor(studentsdata$math.score)
studentsdata$reading.score = as.factor(studentsdata$reading.score)
studentsdata$writing.score = as.factor(studentsdata$writing.score)

library(dummies)
?dummies

testdummy = dummy.data.frame(studentsdata)
names(testdummy)

x = c(2,7,13,15,17)
testdummy = testdummy[,-x]


#Kmeans : FAILED
wbybss = c()
for( i in 2:15){
  kmodel = kmeans(testdummy, centers = i)
  wbybss = c(wbybss, mean(kmodel$withinss)/kmodel$betweenss)
}

plot(2:15,wbybss,type = 'l')

kmodel = kmeans(testdummy, 7)

kmodel$centers


#################################################################
#################################################################
#################################################################
#trying converting into numeric

str(studentsdata)
studentsdata$gender = as.character(studentsdata$gender)
studentsdata$gender = ifelse(studentsdata$gender == "female", 1, 0)

studentsdata$race.ethnicity = as.character(studentsdata$race.ethnicity)
table(studentsdata$race.ethnicity)
studentsdata$race.ethnicity = ifelse(studentsdata$race.ethnicity == "group A", 1, ifelse(studentsdata$race.ethnicity == "group B", 2, ifelse(studentsdata$race.ethnicity == "group C", 3, ifelse(studentsdata$race.ethnicity == "group D", 4, 5))))

studentsdata$parental.level.of.education = as.character(studentsdata$parental.level.of.education)
table(studentsdata$parental.level.of.education)
studentsdata$parental.level.of.education = ifelse(studentsdata$parental.level.of.education == "associate's degree", 1, ifelse(studentsdata$parental.level.of.education == "bachelor's degree", 2, ifelse(studentsdata$parental.level.of.education == "high school",3, ifelse(studentsdata$parental.level.of.education == "master's degree", 4, ifelse(studentsdata$parental.level.of.education == "some college", 5, 6)))))

studentsdata$lunch = as.character(studentsdata$lunch)
table(studentsdata$lunch)
studentsdata$lunch = ifelse(studentsdata$lunch == "standard", 2,1)


################################################
#another way to convert all the factor variables
#to numeric by assigning a number to each level
################################################
studentsdata$test.preparation.course
table(studentsdata$test.preparation.course)

levels(studentsdata$test.preparation.course) = c(1,2)

studentsdata$test.preparation.course = as.numeric(studentsdata$test.preparation.course) 

###kmeans
wbybss = c()
for(i in 2:15){
  kmodel = kmeans(studentsdata, centers = i)
  wbybss = c(wbybss, mean(kmodel$withinss)/kmodel$betweenss)
}

plot(2:15, wbybss, type = 'l')  

kmodel = kmeans(studentsdata, centers = 6)
kmodel$centers


table(kmodel$cluster)




hdata = studentsdata

sum(hdata$math.score > 40 & hdata$reading.score > 40)

hdata$result = ifelse(hdata$math.score > 50 & hdata$reading.score > 50 & hdata$writing.score > 50 , 1,0)

hdata$writing.score = NULL
hdata$reading.score = NULL
hdata$math.score = NULL
str(hdata)
table(hdata$result)

levels(hdata$result)

sum(is.na(hdata))



##Decision Tree
table(hdata$result)
ddata = hdata

ddata$gender = as.factor(ddata$gender)
ddata$race.ethnicity = as.factor(ddata$race.ethnicity)
ddata$parental.level.of.education = as.factor(ddata$parental.level.of.education)
ddata$lunch = as.factor(ddata$lunch)
ddata$test.preparation.course = as.factor(ddata$test.preparation.course)
str(ddata)
ddata$result = as.factor(ddata$result)

library(rpart)
dtree1 = rpart(result~.,data = ddata,control=c(cp=0.01,maxdepth=5))
#reduce cp to increase complexity
plotcp(dtree1)
#D Tree Plot
#install.packages('rpart.plot')
library(rpart.plot)
rpart.plot(dtree1)




### Assigning row names to a dataset which is useful mostly in hierarchical clustering
studentsdata = read.csv('StudentsPerformance.csv')

testdata = head(studentsdata)

x = c()
for( i in 1:nrow(studentsdata)){
  x = c(x, paste("Students", i))    
}

rownames(studentsdata) = x


studentsdata$result = ifelse(studentsdata$math.score > 50 & studentsdata$reading.score > 50 & studentsdata$writing.score > 50 , 1,0)

studentsdata$writing.score = NULL
studentsdata$reading.score = NULL
studentsdata$math.score = NULL
str(studentsdata)

#As dataset is large, lets sample it small

#Stratified Sampling
# Divide population into k non overlapping distinct subpopulations called strata
set.seed(1)

#install.packages('splitstackshape')
library(splitstackshape)
x = names(studentsdata)
out = studentsdata
studentsdata <- stratified(studentsdata, x, 0.1)
?stratified
out = studentsdata
x = c()
for( i in 1:nrow(out)){
  x = c(x, paste("Students", i))    
}
rownames(out) = x
View(out)


dmatrix = dist(out, method = "euclidean")
View(as.matrix(dmatrix))

hmodel = hclust(dmatrix)
plot(hmodel)
