#Jaron Whittington Stat 330 Section 2
#Code for the Tree Models Homework

#Read in the data 
pga <- read.csv("http://www.stat.tamu.edu/~sheather/book/docs/datasets/pgatour2006.csv", header = T, as.is = T)
str(pga)

#The response variable is average Prize Money earned, which is quantitative
#All explanatory variables are quantitavie 

#Grab Tiger Woods to predict later
tiger <- subset(pga, Name == "Tiger Woods")

#filter the data

pga <- subset(pga, Name != "Tiger Woods") #eliminate Tiger Woods
pga <- pga[c(3:12)] #filter to desired variables

#Create test and train datasets our train dataset will get 150 golfers

set.seed(12)
train.rows <- sample(195, 150)

pga.train <- pga[train.rows,]
pga.test <- pga[-train.rows,]

#confirm the train and test datasets are similar
summary(pga.train$PrizeMoney)
summary(pga.test$PrizeMoney)

#Fit the Random Forest Model
library(randomForest)
out.pga <- randomForest(x = pga.train[-1], y = pga.train$PrizeMoney, 
                        xtest = pga.test[-1], ytest = pga.test$PrizeMoney,
                        replace = TRUE, #bootsrap sample
                        keep.forest = T,
                        ntree = 200, mtry = 3, nodesize = 5)
#Find the train and test RMSE's
out.pga
sqrt(1611387021)
sqrt(1446050607)
#subset Tiger to the variables used
tiger <- tiger[c(3:12)]
#make prediction
predict(out.pga, newdata = tiger)
varImpPlot(out.pga)
#3 most important variables: Birdie Conversion, Bounce Back, and GIR
