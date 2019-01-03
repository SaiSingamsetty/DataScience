ecomdata = read.csv("EcommerceData.csv")
str(ecomdata)

nrow(ecomdata)
length(unique(ecomdata$InvoiceNo))
length(unique(grepl('c',ecomdata$InvoiceNo)))
?grepl

nrow(ecomdata[grepl('C',ecomdata$InvoiceNo),])

# Customer details are unavailable.
sum(is.na(ecomdata$CustomerID))

ecomdata = ecomdata[!is.na(ecomdata$CustomerID), ]

#Remove duplicates
ecomdata = distinct(ecomdata)


nrow(ecomdata[ecomdata$CustomerID == 12583 && ecomdata$InvoiceDate %in% '12/1/2010 8:45', ])
























