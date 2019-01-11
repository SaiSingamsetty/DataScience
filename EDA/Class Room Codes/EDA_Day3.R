library(ggplot2)

data(mpg)
mpg


##### Limiting X axis and Y Axis
a= ggplot(mpg, aes(cty, hwy, col=drv)) + 
  geom_point()+
  coord_cartesian(xlim =c(15, 25) , ylim =c(15, 30))

  
x = a + ggtitle('City Mileage vs Highway Mileage')
x + xlab('City Mileage')  + ylab('Highway Mileage')


ggplot(mpg, aes(cty, hwy, col=drv)) + 
  geom_point()+
  coord_cartesian(xlim =c(15, 25) , ylim =c(15, 30))+
  ggtitle('City Mileage vs Highway Mileage')+
  xlab('City Mileage')  + 
  ylab('Highway Mileage') +
  scale_x_continuous(breaks = seq(15,25,0.5))+
  scale_y_continuous(breaks = seq(15,30,0.5))+
  theme(axis.text.x = element_text(angle=45, vjust = 0.5, size=15),
        axis.title.x = element_text(vjust = 0.5, size=20),
        axis.text.y = element_text(angle=0, vjust = 0.5, size=15),
        axis.title.y = element_text(vjust = 0.5, size=20))

  #theme_bw() #### Theme_bw,theme_classic, theme_dark


#### Adding Title and changing axis names
b = a + xlab("City Mileage") + 
  ylab("Highway Mileage") + 
  ggtitle("City Vs Higway mileage by class and drive type ")

### Adding themes
b + theme_classic()
b + theme_dark()
c = b + theme_bw()

### Adding more x and y axis ticks
d = c + 
  scale_x_continuous(breaks=seq(15,25,0.5))+
  scale_y_continuous(breaks=seq(15,30,2))


#### Adjusting labels
d+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, size = 15))

### Adding text in a plot

ggplot(mpg, aes(class))+
  geom_bar()+
  geom_text(aes(label=..count..),stat = "count")

ggplot(mpg, aes(class))+
  geom_bar()+
  geom_label(aes(label=..count..),stat = "count")

ggplot(mpg, aes(class, fill=drv))+
  geom_bar()+
  geom_label(aes(label=..count..),stat = "count", position = "stack")

#### The above can also be done by 
tab = table(mpg$class, mpg$drv)
tab = as.data.frame(tab)

ggplot(tab, aes(x=Var1, y=Freq, fill=Var2))+
  geom_bar(stat='identity')+
  geom_text(aes(label=Freq), position = 'stack', check_overlap = TRUE)


meanMileage = as.data.frame(aggregate(cty~trans, mpg, FUN=mean))
ggplot(meanMileage, aes(trans, cty))+
  geom_bar(stat='identity')+
  geom_text(aes(label=round(cty)),vjust=-0.5)



ggplot(tab, aes(x = Var1, y = Freq, fill = Var2)) +
  geom_bar( stat = "identity") +
  geom_text(aes(label = Freq),position = 'stack', check_overlap = TRUE)+
  theme(axis.title.x = element_text(face="bold", size=9, angle=90),
        axis.text.x = element_text(face="bold", size=9, angle=45,vjust = 0.75))

#### Line Charts
### Multiple line charts 

time = c(2000:2017)
apac = runif(18, min = 110, max= 150)
americas = runif(18, min = 100, max = 160 )
latin = runif( 18, min = 120, max = 130)
emea = runif(18, min = 130, max = 160)
df1 = data.frame(time, apac, americas, latin, emea)

a = ggplot(df1, aes(time, apac)) + 
  geom_line( col = "red") + 
  geom_point()

ggplot(df1)+
  geom_line(aes(time,apac), col='red')+
  geom_point(aes(time,apac))+
  geom_line(aes(time,emea),col='blue')+
  geom_point(aes(time,emea))+
  geom_line(aes(time,latin),col='green')+
  geom_point(aes(time,latin))


a + geom_line(aes(time, emea), col="blue") + 
  geom_point(aes(time, emea))+
  geom_line(aes(time, americas), col = "orange") + 
  geom_point(aes(time, americas))+ 
  geom_line( aes(time, latin), col = "black") + 
  geom_point(aes(time,latin))

### the above can be done by reshaping the data
### Reshape the data -- Converting wide to long
library(reshape2)
df2 = melt(df1, id = "time")

ggplot(df2, aes(time,value, col=variable))+
  geom_line()+
  geom_point()+
  coord_cartesian(ylim =c(0, 200))



ggplot( df2, aes(time, value, col = variable)) + 
  geom_point() + 
  geom_line()+
  geom_text(aes(label=round(value)), check_overlap=TRUE)

