library(ggplot2)
data(mpg)
mpg = as.data.frame((mpg))
str(mpg)

studentsdata = read.csv('StudentsPerformance.csv')
str(studentsdata)
names(studentsdata)



ggplot(studentsdata, aes(math.score)) +
  geom_histogram(bins = 50)

ggplot(studentsdata) +
  geom_histogram(aes(math.score), bins = 50, fill = 'Red', alpha =0.2) +
  geom_histogram(aes(reading.score), bins = 50, fill = 'Blue', alpha =0.2) +
  geom_histogram(aes(writing.score), bins = 50, fill = 'green', alpha =0.2) 


ggplot(studentsdata) +
  geom_histogram(aes(math.score), bins = 50, fill = 'Red') +
  geom_histogram(aes(reading.score), bins = 50, fill = 'Blue') +
  geom_histogram(aes(writing.score), bins = 50, fill = 'green') 
  
# Hightest : Green -> Writing Score
# Lowest : Red -> Math


studentsdata$AvgScore = (studentsdata$math.score + studentsdata$reading.score + studentsdata$writing.score)/3

ggplot(studentsdata) +
  geom_histogram(aes(AvgScore, col = lunch), bins = 20)

ggplot() +
  geom_histogram(data = studentsdata[studentsdata$lunch == 'free/reduced',],aes(AvgScore), fill= 'red', alpha =0.2) +
  geom_histogram(data = studentsdata[studentsdata$lunch == 'standard',],aes(AvgScore), fill= 'blue', alpha =0.2) 


ggplot(studentsdata,aes(AvgScore, c(1:1000) ,shape = test.preparation.course, col = lunch))+
  geom_point()

ggplot(studentsdata, aes(parental.level.of.education, fill = lunch))+
  geom_bar()





























