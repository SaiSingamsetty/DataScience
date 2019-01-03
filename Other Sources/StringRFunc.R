#https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html
#http://edrub.in/CheatSheets/cheatSheetStringr.pdf
#https://r4ds.had.co.nz/strings.html
#https://rpubs.com/iPhuoc/stringr_manipulation


#install.packages("stringr")

library(stringr)
?stringr

studentsdata = read.csv(file.choose())

#get the length of the string 
str_length(studentsdata[1,2])

#Extract and replace substrings from a character vector.
str_sub(studentsdata[,2],1,7)

#Will replace the string given between the positions provided
str_sub(studentsdata[,2],6,6) <- ' ' 


#there are some examples well explained
?str_sub


#pads a string to a fixed length by adding extra whitespace on the left, right, or both sides.
str_pad(c("a", "abc", "abcdef"), 9, side = "left")

x = c("Short", "This is a long string")
x %>% str_trunc(10) %>% str_pad(10, "right")

?str_trunc

x <- "This string is moderately long"
rbind(
  str_trunc(x, 20, "right"),
  str_trunc(x, 20, "left"),
  str_trunc(x, 20, "center")
)

#The opposite of str_pad() is str_trim(), which removes leading and trailing whitespace
x <- c('  a ','   b  ')
str_trim(x)



#Locale sensitive
str_to_upper(studentsdata$gender)
str_to_title(studentsdata$gender)
str_to_lower(studentsdata$gender)

########################################################################################
#######################################################################################

addresses <- c("14 Pine Street, Los Angeles", "152 Redwood Street, Seattle", "8 Washington Boulevard, New York")
products <- c("TV", "laptop", "portable charger", "Wireless Keybord", "HeadPhones")
ong_sentences <- stringr::sentences[1:10]
field_names <- c("order_number", "order_date", "customer_email", "product_title", "amount")
employee_skills <- c("John Bale (Beginner)", "Rita Murphy (Pro)","Chris White (Pro)", "Sarah Reid (Medium)")



#https://www.r-exercises.com/2018/10/01/pull-the-right-strings-with-stringr-exercises/
#https://www.r-exercises.com/2017/07/14/hacking-strings-with-stringr/
#https://www.r-bloggers.com/pull-the-right-strings-with-stringr-exercises/

#1 Normalize the addresses vector by replacing capitalized letters with lower-case ones.
library(stringr)
str_to_lower(addresses)

#2 Pull only the numeric part of the addresses vector.
#extracts only numbers/ digits from each value in a vector
str_extract(addresses, pattern = "[:digit:]+")
str_extract_all(addresses, pattern = "[:digit:]+")

#3 Split the addresses vector into two parts: address and city. The result should be a matrix.
str_split(addresses, ",", simplify = TRUE)

#4 Now try to split the addresses vector into three parts: house number, street and city. The result should be a matrix.
?str_extract
str_split(addresses, "(?<=[:digit:]) |, ", simplify = TRUE)

#5 Show only the first 20 characters of all sentences in the long_sentences vector. To indicate that you removed some characters, use two consecutive periods at the end of each sentence.
str_trunc(ong_sentences, width = 22, ellipsis = "..")


#6 Normalize the products vector by removing all unnecessary whitespaces (both from the start, the end and the middle), and by capitalizing all letters.

str_squish() # returns after removing spaces from the vector head and tail

str_squish2 = function(z){
  x = str_split(z,' ',simplify = T)
  y = c()
  for(i in 1:nrow(x))
  {
    y = c(y,str_squish(paste0(x[i,1],x[i,2],sep = "" )))
  }
  return(y)
  
}

str_to_upper(str_squish2(products))


#7 Prepare the field_names for display, by replacing all of the underscore symbols with spaces, and by converting it to the title-case.

field_names

str_to_title(str_replace_all(field_names, pattern = "_", replacement = " "))


#8 Align all of the field_names to be with equal length, by adding whitespaces to the beginning of the relevant strings.

lengthfield_names

x = str_to_title(str_replace_all(field_names, pattern = "_", replacement = " "))
str_pad(x,15,side = c("left"))
?str_pad


#9 
employee_skills

x = grepl("Pro", employee_skills) | grepl("Medium", employee_skills)

y = str_split(employee_skills," ",simplify = T)
y

z1 = c()
z2 = c()
for(i in 1:nrow(y)){
  z1 = c(z1, paste(y[i,1], y[i,2]))
  z2 = c(z2, y[i,3])
}
z1 = z1[x]
z2 = z2[x]

# sub with '.' : remove first character,  '.$' removes last character
z2 = sub('.','',sub('.$','',z2))
z2

df = data.frame(z1,z2)
df1 = df[x,]
as.matrix(df)

###########################################################################################
x <- "I AM SAM. I AM SAM. SAM I AM" 
y <- "THAT SAM-I-AM! THAT SAM-I-AM! I DO NOT LIKE THAT SAM-I-AM!"
z <- "DO WOULD YOU LIKE GREEN EGGS AND HAM?"


#1 STringr function to merge x y z
?paste
paste(c(x,y,z), collapse = '.')
paste(x,y,z,sep = '.')
paste(c(x,y),z, collapse = '.')
#collapse is to merge results. sep is to merge terms

#2 similar to #1 if NA is present in list 
paste(c(x,y,z,NA), collapse = '.')
str_c(c(x,y,z,NA), collapse = '.')
?str_c
str_c(x,y,z,NA, sep = '..')

#3 In mtcars dataset rownames, find all cars of the brand Merc 
library(MASS)
data("mtcars")
mydata = mtcars

rownames(mtcars)

#returns all the strings which has the specified pattern
str_subset(rownames(mydata),"Merc")

#Example
fruit <- c("apple", "banana", "pear", "pinpple")
str_subset(fruit, "a")


#4 Use the same mtcars rownames ,find the total number of times "e" appears in that .
length(str_subset(rownames(mydata),"e")) # how many has 'e'
str_count(rownames(mydata),"e") # how many has 'e' individually


#5 Split below sentence
j <- "The_quick_brown_fox_jumps_over_the_lazy_dog"
str_split(j,"_")


#6 On the same string I need the first word splitted but the rest intact ,help me to achieve that

j <- "The_quick_brown_fox_jumps_over_the_lazy_dog"
str_split(j,"_",n=3,simplify = T)   # n is no of pieces to return


#7 I want the first "_" replaced by "-"  for string j
j <- "The_quick_brown_fox_jumps_over_the_lazy_dog"
str_replace(j,"_","-") # replaces only first occurence

#to replace all occurences
str_replace_all(j,"_","-")


#8 Turn NA to "NA" if it is needed 
na_string_vec <- c("The_quick_brown_fox_jumps_over_the_lazy_dog",NA)

str_replace_na(na_string_vec)


#9 We often use substr to get part of the string ,in stringr world there exist a much powerful function which does almost the same thing . Create a string name with your name .
#Use str_sub to get the last character and the last 5 characters .

s = "Sai Teja Singamsetty"
str_sub(s,-1) # y
str_sub(s,-5) # setty
str_sub(s,1)  # Sai Teja Singamsetty



############################################################################################

#https://stringr.tidyverse.org/articles/regular-expressions.html
#https://r4ds.had.co.nz/strings.html

library(tidyverse)
library(stringr)

string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'

# Use \ as escape character.
# if we normally excute string3 , it will show \ as well. because printed representation in console
#shows escapes. To see original content use the below method
string3 <- 'If I want to include a \'quote\' inside a string, I use single quotes'

writeLines(string3)

########################
#the functions here by discussed are all from stringr package


#str_length() tells you the number of characters in a string
str_length(c("a", "R for data science", NA))


#To combine two or more strings, use str_c()
str_c("a","bcd","efgh")
str_c("a","bcd","efgh",sep = "_")

#str_c is vectorized.
str_c("prefix-", c("a", "b", "c"), "-suffix")


#Like most other functions in R, missing values are contagious. 
#If you want them to print as "NA", use 
x <- c("abc", NA)
str_c("|-", x, "-|")  #> [1] "|-abc-|" NA
str_c("|-", str_replace_na(x), "-|")  #> [1] "|-abc-|" "|-NA-|"

str_c("abc",str_replace_na(NA))  # it converts NA to "NA"

# To collapse a vector of strings into a single string, use collapse:
str_c(c("x", "y", "z"))
str_c(c("x", "y", "z"), collapse = ", ")   #> [1] "x, y, z"
#sep = " " we can use when we are passing strings directly
#collapse = " "  : we can use when we are passing vector of strings



# You can extract parts of a string using str_sub()
#str_sub is also vectorized

x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
# negative numbers count backwards from end
str_sub(x, -3, -1)

# Note that str_sub() won't fail if the string is too short: it will just return as much as possible:
str_sub("a", 1, 5)

str_sub(x, 1, 2) <- str_to_upper(str_sub(x, 1, 2))
x



### Matching patterns with regular expressions

#To learn regular expressions, we'll use str_view() and str_view_all()
#install.packages("htmlwidgets")
library(htmlwidgets)

x <- c("apple", "banana", "pear")
str_view(x, "an")

# to match any string, we use '.'
str_view(x,'a.')
str_view(x,'.a.')

#But what if we actually need to match a '.'
y = c("app","a.c","bef")
#how to match 'a.c' ? We use escape sequences here.
str_view(y, "a\.c")
# error ? Yes, we are placing that in a string, so it trying to check if there is any escape 
# sequence as \.   There is nothing like that. So Errr. 
#To Escape the escape sequence we nullify it by adding another \
str_view(y, "a\\.c")

#more detailed : https://r4ds.had.co.nz/strings.html


# Anchors
#By default, regular expressions will match any part of a string. It's often useful to anchor the regular expression so that it matches from the start or end of the string. You can use:

#   ^ to match the start of the string.
#   $ to match the end of the string.

x <- c("apple", "banana", "pear")
str_view(x, "^a")
str_view(x, "a$")

# To force a regular expression to only match a complete string, anchor it with both ^ and $
x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")

#How would you match the literal string "$^$"?
x <- c("$^$","^$^$$")
str_view(x, "^\\$\\^\\$$") # Perfect !

str_view(x, "^\$\^\$$")
# if we try with single \, it searches for escape sequences in STRINGS, but \\ is something 
# we use as escape in REGEX


#Exercise
x = stringr::words
#1 Start with "y".
str_subset(x,"^y")
#2 End with "x"
str_subset(x,"x$")
#3 Are exactly three letters long.
str_subset(x,"^...$")
#4 Have seven letters or more.
str_subset(x, "^.......")

#checking #4
min(str_length(str_subset(x,"^.......")))



## There are four other useful tools:
# \d: matches any digit
# \s: matches any whitespace (e.g. space, tab, newline).
# [abc]: matches a, b, or c.
# [^abc]: matches anything except a, b, or c.


## Remember, to create a regular expression containing \d or \s, 
#you'll need to escape the \ for the string, so you'll type "\\d" or "\\s".


str_view(c("abc", "a.c", "a*c", "a c"), "a[.]c")
str_view(c("abc", "a.c", "a*c", "a c"), ".[*]c")
str_view(c("abc", "a.c", "a*c", "a c"), "a[ ]")
str_view(c("abc", "a.c", "a*c", "a(c"), "a[(*]c")

str_view(c("abc", "d..f", "a*c", "a c","deaf","d..."), "abc|d..f")

str_view(c("abc", "d..f", "a*c", "a c","deaf","d...","abc..f","abd..f","ab...f","abcdef"), "ab(c|d)..f")

#For example, abc|d..f will match either '"abc"', or "deaf". 
#Note that the precedence for | is low, so that abc|xyz matches abc or xyz not abcyz or abxyz. 
#Like with mathematical expressions, if precedence ever gets confusing, use parentheses


#Excercise
#1 Start with a vowel.
str_subset(x,"^[aeiou]")
length(str_subset(x,"^[aeiou]"))

#2 That only contain consonants.
str_subset(x,"^[^aeiou]+$")  # + to repeat for the next characters too in the string till end.
#play in the below url
#https://regex101.com/r/sW3mX8/1 


#3 End with ed, but not with eed.
str_subset(x,".[^e]ed$")

#4 End with ing or ise.
str_subset(x, ".(ing|ise)$")

#5 Create a regular expression that will match telephone numbers as commonly written in your country.
phones = c("+91 8099880974","8088776654")
str_subset(phones,"^[+91]+[ ]+\\d{10}$")
str_subset(phones,"^\\d{10}$")



#Repetition
#The next step up in power involves controlling how many times a pattern matches:
  
# ?: 0 or 1
# +: 1 or more
# *: 0 or more

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
y = c("CCC","CC","CX")
str_view(y, "CC?")
str_view(y, "CC+")
str_view(y, "CC*")

#You can also specify the number of matches precisely:

#{n}: exactly n
#{n,}: n or more
#{,m}: at most m
#{n,m}: between n and m

str_view(y,"C{3}")
str_view(y,"C{2}")
str_view(y,"C{2,}")
str_view(y,"C{1,}")
str_view(y,"C{1,3}")
str_view(y,"C{1,3}?")
str_view(y,"C{1,}?")


fruit = c("banana","apple","jujube","coconut")
str_view(fruit, "(..)\\1", match = TRUE)

# Detect matches

x <- c("apple", "banana", "pear")
str_detect(x, "e")
#returns boolean
sum(str_detect(x,"e"))

words[str_detect(words, "x$")]
#> [1] "box" "sex" "six" "tax"
str_subset(words, "x$")
#> [1] "box" "sex" "six" "tax"

x <- c("apple", "banana", "pear")
str_count(x, "a")


# On average, how many vowels per word?
mean(str_count(words, "[aeiou]"))
#> [1] 1.99








































