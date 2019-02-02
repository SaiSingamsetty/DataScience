unibank = read.csv('universalBank.csv')

# Removing unnecessary columns
unibank$ID = NULL
unibank$ZIP.Code = NULL

str(unibank)

# EDA
library(ggplot2)

# No of Personal Loan takers and Non takers
table(unibank$Personal.Loan)
barplot(table(unibank$Personal.Loan))
