mydata = amazon_alexa

names(mydata)=c("Ratings","Date","Variation","Verified_reviews","Feedback")
table(mydata$Variation)
str(mydata)

tempdata = mydata[mydata$Feedback == 0,]
table(tempdata$Variation)


